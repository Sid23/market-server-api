class Api::V1::UsersController < ApplicationController

    def index
        render json: User.where(type: nil)
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        if current_api_user[:id] == params[:id]
            user = User.find(id)
            if user.update(user_params)
                render json: user, status: 201
            else
                render json: { errors: user.errors }, status: 422
            end
        else
            render json: { errors: "Cannot update other users" }, status: :not_authorized
        end
    end

    def destroy

    end
    
    private
    
        def user_params
          params.require(:user).permit(:email, :password, :id, :password_confirmation, :name, :surname)
        end
end
