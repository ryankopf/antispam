require_dependency "antispam/application_controller"

module Antispam
  class SignupsController < ApplicationController
    before_action :must_be_admin
    def index
      @signups = Signup.order(created_at: :desc).limit(100).offset(params[:page].to_i * 100)
    end
  end
end
