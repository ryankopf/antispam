require_dependency "antispam/application_controller"

module Antispam
  class ChallengesController < ApplicationController
    #skip_before_filter :verify_authenticity_token
    before_action :set_challenge, only: [:show, :edit, :update, :destroy]

    # GET /challenges/1
    def show
      respond_to do |format|
        format.html
        format.jpeg do
          image = @challenge.get_image
          render content_type: 'image/jpeg', plain: image.jpegsave_buffer
        end
      end
    end

    # GET /challenges/new
    def new
      # use in the future for changing code
    end

    # PATCH/PUT /challenges/1
    def update
      if @challenge.validate?(params[:challenge][:answer])
        c = Clear.create(ip: request.remote_ip, answer: params[:challenge][:answer], result: 'Passed')
        a = Antispam::Ip.find_or_create_by(address: request.remote_ip, provider: 'httpbl')
        a.threat = [(a.threat || 0) - 25, 0].max
        a.expires_at = 1.hour.from_now
        a.save
        redirect_to '/'
      else
        c = Clear.create(ip: request.remote_ip, answer: params[:challenge][:answer], result: 'Failed')
        redirect_to '/antispam/validate', notice: 'Invalid answer.'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_challenge
        @challenge = Challenge.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def challenge_params
        params.require(:challenge).permit(:answer, :code)
      end
  end
end
