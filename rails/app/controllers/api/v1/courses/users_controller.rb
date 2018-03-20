class Api::V1::Courses::UsersController < ApplicationController

    def index
        render json: Course.find(params[:course_id]).users
    end
end