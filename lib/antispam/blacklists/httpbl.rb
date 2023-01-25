require 'resolv'
module Antispam
  module Blacklists
    class Httpbl
      def self.check(ip, key, verbose)
        threat = 0
        begin
          old_result = get_old_result(ip)
          if old_result
            Rails.logger.info "Returning old result for #{ip}." if verbose
            return get_old_result(ip)
          end
          check = ip.split('.').reverse.join('.')
          host = key + '.' + check + ".dnsbl.httpbl.org"
          address = Resolv::getaddress(host)
          z,days,threat,iptype = address.split('.')
          Rails.logger.info "Spam located: #{iptype} type at #{threat} threat. (#{ip} - #{address})" if verbose
          threat = threat.to_i
          # Create or update
          if (threat > 30)
            Rails.logger.info "Spamcheck: Very high, over 30!" if verbose
          end
        rescue Exception => e
          case e
          when Resolv::ResolvError #Not spam! This blacklist gives an error when there's no spam threat.
            Rails.logger.info "Spamcheck: OK! Resolve error means the httpbl does not consider this spam." if verbose
          when Interrupt #Something broke while trying to check blacklist.
            Rails.logger.info "Spamcheck: Interrupt when trying to resolve http blacklist. Possible timeout?" if verbose
          else # Time Out
            Rails.logger.info "Spamcheck: There was an error, possibly a time out, when checking this IP." if verbose
            Rails.logger.info e.to_s if verbose
          end
        end
        update_old_result(ip, threat)
        return threat
      end
      def self.get_old_result(ip)
        result = Antispam::Ip.find_by(address: ip, provider: 'httpbl')
        return nil if (result.nil? || result.expired?)
        return result.threat
      end
      def self.update_old_result(ip, threat)
        result = Antispam::Ip.find_or_create_by(address: ip, provider: 'httpbl')
        result.update(threat: threat, expires_at: 24.hours.from_now)
      end
    end
  end
end
