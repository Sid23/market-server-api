class Api::V1::AdminsController < ApplicationController

    def index
        render json: Admin.all
    end
    
    def show
        render json: Admin.find(params[:id])
    end

    def update

    end

    def destroy

    end

    private
    
        def admin_params
          params.require(:admin).permit(:id, :email, :password, :password_confirmation, :name, :surname)
        end
end