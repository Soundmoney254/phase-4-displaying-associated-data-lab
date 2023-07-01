class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def show
      @user = User.find(params[:id])
      @items = @user.items
      render json: {
        id: @user.id,
        username: @user.username,
        city: @user.city,
        items: @items.map { |item| item.as_json(except: [:created_at, :updated_at, :user_id]) }
      }, except: [:created_at, :updated_at]
    end
  
    private
    def render_not_found_response
      render json: { error: "User not found" }, status: :not_found
    end
  end
  