module Antispam
  class ApplicationController < ActionController::Base
    def must_be_admin
      begin
        render plain: '' unless is_admin?
      rescue
        render plain: ''
      end
    end
  end
end
