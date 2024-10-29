module Antispam
  module Tools
    # Checks spam against an IP database of spammers.
    # Usage: before_action :check_ip_against_database
    def check_ip_against_database(
        ip_blacklists: { default: '' },
        methods: nil,
        scrutinize_countries_except: nil,
        verbose: false
      )
      if methods
        return if request.get? && !methods.include?(:get)
        return if request.post? && !methods.include?(:post)
        return if request.put? && !methods.include?(:put)
        return if request.patch? && !methods.include?(:patch)
        return if request.delete? && !methods.include?(:delete)
      else
        return if request.get?
      end
    
      return if skip_if_user_whitelisted
      return if controller_name.in?(%w[validate challenges])
    
      ip = request.remote_ip
    
      # Handle IP blacklists
      if ip_blacklists
        ip_blacklists[:httpbl] ||= ip_blacklists.delete(:default)
        check_ip_against_blacklists(ip, ip_blacklists, verbose)
      end
    
      # Country checks, if necessary
      # (expand logic as needed)
      Rails.logger.info "Completed IP database check. #{ip}" if verbose
    end    
    # Checks the specific blacklists
    def check_ip_against_blacklists(ip, lists, verbose)
      results = []
      lists.each do |provider_name, provider_api_key|
        Rails.logger.info "Checking provider: #{provider_name}" if verbose
        results.append blacklist(provider_name).check(ip, provider_api_key, verbose)
      end
      result = Antispam::BlacklistResult.new(results)
      if result.is_bad?
        Block.create(ip: ip, provider: lists.keys.first, threat: result)
        redirect_to '/antispam/validate'
      end
    end
    def skip_if_user_whitelisted
      if respond_to? :current_user
        if current_user && current_user.respond_to?(:antispam_whitelisted?)
          return true if current_user.antispam_whitelisted?
        end
      end
    end
    def blacklist(provider)
      class_name = provider.to_s.camelize
      raise Antispam::NoSuchBlacklistError unless Antispam::Blacklists.const_defined? class_name
      Antispam::Blacklists.const_get class_name
    end
  end
  class NoSuchBlacklistError < StandardError; end
end
