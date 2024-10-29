require "antispam/version"
require "antispam/engine"
require "antispam/tools"
require "antispam/checker"
require "antispam/blacklists/httpbl"
require "antispam/spamcheckers/defendium"
require "antispam/results"

module Antispam
  ActiveSupport.on_load(:action_controller_base) do
    # Include Antispam::Tools into the application's ApplicationController
    # Use ::ApplicationController to reference the top-level class
    if defined?(::ApplicationController)
      ::ApplicationController.include Antispam::Tools
    else
      Rails.application.config.to_prepare do
        ::ApplicationController.include Antispam::Tools
      end
    end
  end
end
