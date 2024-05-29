module Api 
  module V1
    class BeehivesController < ApplicationController
      before_action :set_beehive, only: [:show]
  
      def index
        @beehives = Beehive.page(params[:page]).per(10)
        render json: {
          beehives: @beehives,
          meta: {
            current_page: @beehives.current_page,
            next_page: @beehives.next_page,
            prev_page: @beehives.prev_page,
            total_pages: @beehives.total_pages,
            total_count: @beehives.total_count
          }
        }
      end
  
      def show
        render json: @beehive
      end
  
      def create
        @beehive = Beehive.new(beehive_params)
        if @beehive.save
          render json: @beehive, status: :created
        else
          render json:  { errors: @beehive.errors }, status: :unprocessable_entity
        end
      end
      
      private
  
      def set_beehive
        @beehive = Beehive.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Beehive not found" }, status: :not_found
      end
  
      def beehive_params
        params.require(:beehive).permit(:name, :weight)
      end
    end
  end
end