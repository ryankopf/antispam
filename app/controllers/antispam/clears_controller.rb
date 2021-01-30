require_dependency "antispam/application_controller"

module Antispam
  class ClearsController < ApplicationController
    before_action :set_clear, only: [:show, :edit, :update, :destroy]

    # GET /clears
    def index
      @clears = Clear.all
    end

    # GET /clears/1
    def show
    end

    # GET /clears/new
    def new
      @clear = Clear.new
    end

    # GET /clears/1/edit
    def edit
    end

    # POST /clears
    def create
      @clear = Clear.new(clear_params)

      if @clear.save
        redirect_to @clear, notice: 'Clear was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /clears/1
    def update
      if @clear.update(clear_params)
        redirect_to @clear, notice: 'Clear was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /clears/1
    def destroy
      @clear.destroy
      redirect_to clears_url, notice: 'Clear was successfully destroyed.'
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
