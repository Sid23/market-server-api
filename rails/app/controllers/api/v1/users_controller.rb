class Api::V1::UsersController < ApplicationController

    def index
        render json: User.all
    end
    
    private
    
        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname)
        end
end
