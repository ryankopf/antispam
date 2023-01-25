#require 'resolv'
module Antispam
  module Spamcheckers
    class Defendium
      def self.check(content, key, verbose)
        # nethttp2.rb
        require 'uri'
        require 'net/http'

        uri = URI('https://api.defendium.com/check')
        params = { secret_key: key, content: content }
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)
        if res.is_a?(Net::HTTPSuccess)
          result = res.body.to_json
          if result["warnings"]
            Rails.logger.info result["warnings"]
          end
          if result["result"]
            return 1
          else
            return 0
          end
        end
      end
    end
  end
end