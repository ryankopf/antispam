require_dependency "antispam/application_controller"

module Antispam
  class BlocksController < ApplicationController
    before_action :must_be_admin
    before_action :set_block, only: [:show]

    # GET /blocks
    def index
      @blocks = Block.all
    end

    # GET /blocks/1
    def show
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_block
        @block = Block.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def block_params
        params.require(:block).permit(:ip, :provider, :controllername, :actionname)
      end
  end
end
