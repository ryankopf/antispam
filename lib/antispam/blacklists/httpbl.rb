require 'resolv'
module Antispam
  module Blacklists
    class Httpbl
      def self.check(ip, key)
        begin
          check = ip.split('.').reverse.join('.')
          host = key + '.' + check + ".dnsbl.httpbl.org"
          address = Resolv::getaddress(host)
          z,days,threat,iptype = address.split('.')
          Rails.logger.info "Spam located: #{iptype} type at #{threat} threat. (#{ip} - #{address})"
          # Create or update
          if (threat.to_i > 30)
            Rails.logger.info "Spamcheck: Denied!"
            return threat.to_i
          end
        rescue Exception => e
          case e
          when Resolv::ResolvError #Not spam! This blacklist gives an error when there's no spam threat.
            Rails.logger.info "Spamcheck: OK! Resolve error means the httpbl does not consider this spam."
          when Interrupt #Something broke while trying to check blacklist.
            Rails.logger.info "Spamcheck: Interrupt when trying to resolve http blacklist. Possible timeout?"
          else # Time Out
            Rails.logger.info "Spamcheck: There was an error, possibly a time out, when checking this IP."
            Rails.logger.info e.to_s
          end
        end
        return 0
      end
    end
  end
end



