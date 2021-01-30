module Antispam
  class Tools
    before_action :check_ip_against_database
    def check_ip_against_database
      Rails.logger.info "Got to this function."

    end
  end
end
