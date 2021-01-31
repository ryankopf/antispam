require_dependency "antispam/application_controller"

module Antispam
  class ClearsController < ApplicationController
    before_action :must_be_admin
    before_action :set_clear, only: [:show, :edit, :update, :destroy]

    # GET /clears
    def index
      @clears = Clear.all
    end

    # GET /clears/1
    def show
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_clear
        @clear = Clear.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def clear_params
        params.require(:clear).permit(:ip, :result, :answer, :threat_before, :threat_after)
      end
  end
end
