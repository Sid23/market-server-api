class Api::V1::UsersController < ApplicationController

    def index
        render json: User.all
    end

    def show
        render json: User.find(params[:id])
    end

    def create
        # Generate random password for new created user
        range = [*'0'..'9',*'A'..'Z',*'a'..'z']
        generated_password = Array.new(10){ range.sample }.join
        user = User.new(
            name: params[:name],
            surname: params[:surname],
            email: params[:email],
            password: generated_password,
            password_confirmation: generated_password
        )

        if user.save
            user.send_welcome_mail
            user.send_reset_password_instructions        
            render json: user, status: :created
        else
            render json: { errors: user.errors }, status: :unprocessable_entity
        end

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
          params.permit(:email, :password, :id, :password_confirmation, :name, :surname)
        end
end
