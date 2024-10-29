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
      if (options[:methods])
        return if request.get? unless options[:methods].include?(:get)
        return if request.post? unless options[:methods].include?(:post)
        return if request.put? unless options[:methods].include?(:put)
        return if request.patch? unless options[:methods].include?(:patch)
        return if request.delete? unless options[:methods].include?(:delete)
      else
        return if request.get?
      end
      return if skip_if_user_whitelisted
      return if controller_name.in?["validate","challenges"]
      ip = request.remote_ip
      # First, check IP blacklists.
      if (options[:ip_blacklists])
        if options[:ip_blacklists][:default]
          options[:ip_blacklists][:httpbl] = options[:ip_blacklists][:default]
          options[:ip_blacklists].delete(:default)
        end
        check_ip_against_blacklists(ip, options[:ip_blacklists], options[:verbose])
      end
      # Second, check for weird countries.
      if (options[:scrutinize_countries_except])

      end
      Rails.logger.info "Completed IP database check. #{ip}" if options[:verbose]
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
