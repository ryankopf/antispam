require "antispam/version"
require "antispam/engine"
require "antispam/tools"
require "antispam/checker"
require "antispam/blacklists/httpbl"
require "antispam/spamcheckers/defendium"
require "antispam/results"

module Antispam
  ActiveSupport.on_load(:action_controller) do
    Rails.application.config.to_prepare do
      unless ApplicationController.method_defined?(:is_admin?)
        raise "Antispam Error: ApplicationController must define `is_admin?` method to use Antispam."
      end
      ActionController::Base.include Antispam::Tools
    end
  end
end
