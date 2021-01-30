module Antispam
  module Tools
    # before_action :check_ip_against_database
    def check_ip_against_database(options = {ip_blacklists: {default: ''}})
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
      Rails.logger.info "Got to this function. #{ip}"
      puts "Got to this function. #{ip}"
    end
    def check_ip_against_blacklists(ip, lists, verbose)
      lists.each do |provider_name, provider_api_key|
        puts "Checking provider: #{provider_name}" if verbose
        if provider_name == :httpbl
          result = Antispam::Blacklists::Httpbl.check(ip, provider_api_key)
          puts result if verbose
          result = 31
          if (result > 30)
            Block.create(ip: ip, provider: provider_name)
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
