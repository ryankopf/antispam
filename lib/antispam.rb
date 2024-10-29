require "antispam/version"
require "antispam/engine"
require "antispam/tools"
require "antispam/checker"
require "antispam/blacklists/httpbl"
require "antispam/spamcheckers/defendium"
require "antispam/results"

module Antispam
  ActiveSupport.on_load(:action_controller_base) do
    ActionController::Base.include Antispam::Tools
  end
end
