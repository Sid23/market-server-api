class Api::V1::UsersController < ApplicationController

    def index
        render json: User.where(type: nil)
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user, status: :accepted
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.destroy
            render status: :no_content
        else
            render json: {errors: appointment.errors}, status: :not_acceptable
        end
    end
    
    private
    
        def user_params
          params.require(:user).permit(:email, :password, :id, :password_confirmation, :name, :surname)
        end
end
