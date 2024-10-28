require "antispam/version"
require "antispam/engine"
require "antispam/tools"
require "antispam/checker"
require "antispam/blacklists/httpbl"
require "antispam/spamcheckers/defendium"
require "antispam/results"

module Antispam
  ActiveSupport.on_load(:action_controller) do
    # Ensure ApplicationController has is_admin? defined
    unless ApplicationController.method_defined?(:is_admin?)
      raise "Antispam Error: ApplicationController must define `is_admin?` method to use Antispam."
    end
    # self refers to ActionController::Base here
    # This way is removed because below may be more compatible.
    # self.include Antispam::Tools
    # Would the below be a better (clearer? more compatible?) way to do this?
    ActionController::Base.send(:include, Antispam::Tools)
  end
end
