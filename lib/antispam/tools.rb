module Antispam
  module Tools
    # before_action :check_ip_against_database
    def check_ip_against_database(options = {ip_blacklists: {default: ''}})
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
      return if controller_name == "validate"
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
    def check_ip_against_blacklists(ip, lists, verbose)
      lists.each do |provider_name, provider_api_key|
        puts "Checking provider: #{provider_name}" if verbose
        if provider_name == :httpbl
          result = Antispam::Blacklists::Httpbl.check(ip, provider_api_key, verbose)
          Rails.logger.info(result) if verbose
          if (result > 30)
            Block.create(ip: ip, provider: provider_name, threat: result)
            redirect_to '/antispam/validate'
          end
        end
      end
    end

    def skip_if_user_whitelisted
      if respond_to? :current_user
        if current_user && current_user.respond_to?(:antispam_whitelisted?)
          return true if current_user.antispam_whitelisted?
        end
      end
    end


  end
end
