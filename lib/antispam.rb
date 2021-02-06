require "antispam/version"
require "antispam/engine"
require "antispam/tools"
require "antispam/blacklists/httpbl"

module Antispam
  ActiveSupport.on_load(:action_controller) do
    # self refers to ActionController::Base here
    self.include Antispam::Tools
    # Would the below be a better (clearer? more compatible?) way to do this?
    # ActionController::Base.send(:include, Antispam::Tools)
  end
end
