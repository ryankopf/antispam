module Antispam
  class ApplicationController < ::ApplicationController
    def must_be_admin
      begin
        render plain: 'Not available.' unless is_admin?
      rescue
        render plain: 'Not available.'
      end
    end
  end
end
