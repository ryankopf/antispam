module Antispam
  class Signup < ApplicationRecord
    def self.analyze(user_id:, ip:)
      ip_integer = IPAddr.new(ip).to_i rescue 0
      signup = Signup.where(user_id: user_id).first_or_initialize
      signup.ip = ip
      signup.country_code = Iplocator.get_country(ip_integer)
      signup.number_from_this_ip = Signup.where(ip: ip).count
      signup.save
      signup.safe?
    end
    def spamscore
      spamscore = 50 # Start at a neutral score
      spamscore += 10 if self.country_code.nil? || (self.country_code == 'ZZ')
      spamscore += 10 if self.number_from_this_ip > 5
      spamscore += 10 if self.number_from_this_ip > 10
      spamscore += 10 if Iplocator.countries_suspected_of_spam.include?(self.country_code)
      spamscore -= 10 if Iplocator.trusted_countries.include?(self.country_code)
      spamscore = [[spamscore, 0].max, 100].min # Clamp to a value between 0 and 100
      spamscore
    end
    def safe?
      self.spamscore <= 50
    end
  end
end
