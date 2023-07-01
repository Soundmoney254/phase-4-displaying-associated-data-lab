class ItemsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        @items = Item.all
        render json: @items.map { |item| item.as_json(except: [:created_at, :updated_at, :user_id], include: { user: { except: [:created_at, :updated_at] } }) }
    end

    private
    def render_not_found_response
    render json: { error: "Items not found" }, status: :not_found
    end
end
