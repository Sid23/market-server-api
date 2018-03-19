class Api::V1::Users::CoursesController < ApplicationController

    def index
        if current_api_user.id.to_s == params[:user_id] || current_api_user.admin?
            # Only list courses where current user is subscribed
            user = User.find(params[:user_id])
            render json: user.courses.all
        else
            unauthorized_action()
        end
    end

    def create
        # There is a :record-not_found method into application controlled that mathch record not found exception
        user = User.find(params[:user_id])
        # Only Admin can create courses, so check if a courses is already saved into db
        if params.has_key(:id)
            course = Course.find(params[:id])
        elsif params.has_key(:code) && params.has_key(:year)
            # Alternative way to find a course
            course = Course.where(code: params(:code), year: params(:year)).first
        else
            # Impossible to find existing course
            unauthorized_action()
            return
        end

        user.courses << course

        if course.save
            render json: course, status: :created
        else
            render json: { errors:course.errors }, status: :unprocessable_entity
        end
    end

    private

        def course_params
            params.permit(:code, :year, :name, :difficulty)
        end
end