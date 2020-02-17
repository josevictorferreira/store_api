module Api
  module V1
    class StockItemsController < ApplicationController
      before_action :set_stock_item, only: [:show, :add_items, :remove_items]

      # GET /stock_items
      def index
        @stock_items = StockItem.all

        render json: @stock_items
      end

      # GET /stock_items/1
      def show
        render json: @stock_item
      end

      # POST /stock_items
      def create
        @stock_item = StockItem.new(stock_item_params)

        if @stock_item.save
          render json: @stock_item,
                 status: :created,
                 location: api_v1_stock_item_url(@stock_item)
        else
          render json: @stock_item.errors, status: :unprocessable_entity
        end
      end

      def add_items
        @stock_item.add_stock_item(change_stock_item_param[:items].to_i)
        render json: @stock_item, status: :ok
      rescue ActiveRecord::RecordInvalid => er
        render json: { message: er.message }, status: :unprocessable_entity
      rescue ArgumentError => e
        render json: { message: e.message }, status: :unprocessable_entity
      rescue StandardError => ex
        render json: { message: ex.message }, status: :unprocessable_entity
      end

      def remove_items
        @stock_item.remove_stock_item(change_stock_item_param[:items].to_i)
        render json: @stock_item, status: :ok
      rescue ActiveRecord::RecordInvalid => er
        render json: { message: er.message }, status: :unprocessable_entity
      rescue ArgumentError => e
        render json: { message: e.message }, status: :unprocessable_entity
      rescue StandardError => ex
        render json: { message: ex.message }, status: :unprocessable_entity
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_stock_item
        @stock_item = StockItem.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def stock_item_params
        params.require(:stock_item).permit(:items, :product_id, :store_id)
      end

      def change_stock_item_param
        params.require(:stock_item).permit(:items)
      end
    end
  end
end
