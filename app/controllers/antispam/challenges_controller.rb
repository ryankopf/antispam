require_dependency "antispam/application_controller"

module Antispam
  class ChallengesController < ApplicationController
    before_action :set_challenge, only: [:show, :edit, :update, :destroy]

    # GET /challenges
    def index
      @challenges = Challenge.all
    end

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
      @challenge = Challenge.new
    end

    # GET /challenges/1/edit
    def edit
    end

    # POST /challenges
    def create
      @challenge = Challenge.new(challenge_params)

      if @challenge.save
        redirect_to @challenge, notice: 'Challenge was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /challenges/1
    def update
      if @challenge.update(challenge_params)
        redirect_to @challenge, notice: 'Challenge was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /challenges/1
    def destroy
      @challenge.destroy
      redirect_to challenges_url, notice: 'Challenge was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_challenge
        @challenge = Challenge.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def challenge_params
        params.require(:challenge).permit(:question, :answer, :code)
      end
  end
end
