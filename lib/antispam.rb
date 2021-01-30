require "antispam/version"
require "antispam/engine"

module Antispam
  # Your code goes here...
  #
  ActionController.on_load(:action_controller) do
    # self refers to ActionController::Base here
    self.include Antispam::Tools
  end
end
