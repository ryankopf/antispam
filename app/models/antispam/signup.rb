require 'net/http'
module Antispam
  class Signup < ApplicationRecord
    def self.analyze(user_id:, ip: nil, request: nil)
      record(user_id: user_id, ip: ip || request&.remote_ip).safe?
    end
    # Like analyze, but also asks Defendium whether the form's _defendium token passed.
    # Returns a hash; :safe is true only if our score is safe and Defendium says "pass".
    def self.check_spam(user_id:, request:)
      signup = record(user_id: user_id, ip: request.remote_ip)
      human_check = verify_human(request)
      {
        safe: signup.safe? && human_check == "pass",
        signup_safe: signup.safe?,
        spamscore: signup.spamscore,
        human_check: human_check,
        country_code: signup.country_code,
        number_from_this_ip: signup.number_from_this_ip
      }
    end
    def self.record(user_id:, ip:)
      ip_integer = IPAddr.new(ip).to_i rescue 0
      signup = Signup.where(user_id: user_id).first_or_initialize
      signup.ip = ip
      signup.country_code = Iplocator.get_country(ip_integer)
      signup.number_from_this_ip = Signup.where(ip: ip).count
      signup.save
      signup
    end
    # Returns "pass", "uncompleted", "spam", or "unknown" if Defendium couldn't be reached.
    def self.verify_human(request)
      token = request.params[:_defendium]
      return "uncompleted" if token.blank?
      uri = URI("https://defendium.com/human/verify")
      body = { token: token.to_s, host: request.host, ip: request.remote_ip, user_agent: request.user_agent.to_s, required: true, secret_key: defendium_api_key }
      response = Net::HTTP.post(uri, body.to_json, "Content-Type" => "application/json")
      return "unknown" unless response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)["result"].to_s.presence || "unknown"
    rescue StandardError
      "unknown"
    end
    # Optional; set in credentials (defendium: api_key:) or ENV["DEFENDIUM_API_KEY"].
    def self.defendium_api_key
      Rails.application.credentials.dig(:defendium, :api_key) || ENV["DEFENDIUM_API_KEY"]
    end
    def spamscore
      spamscore = 50 # Start at a neutral score
      spamscore += 10 if self.country_code.nil? || (self.country_code == 'ZZ')
      spamscore += 10 if self.number_from_this_ip > 5
      spamscore += 10 if self.number_from_this_ip > 10
      spamscore += 10 if Iplocator.countries_suspected_of_spam.include?(self.country_code)
      spamscore -= 5 if self.number_from_this_ip < 2
      spamscore -= 10 if Iplocator.trusted_countries.include?(self.country_code)
      spamscore = [[spamscore, 0].max, 100].min # Clamp to a value between 0 and 100
      spamscore
    end
    def safe?
      self.spamscore < 40
    end
  end
end
