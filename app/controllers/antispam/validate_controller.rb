module Antispam
  class ValidateController < ::ApplicationController
    def index
      respond_to do |format|
        format.html
        format.js { render js: 'window.location = "/antispam/validate"'}
      end
    end
  end
end
