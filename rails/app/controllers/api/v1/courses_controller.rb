class Api::V1::CoursesController < ApplicationController

    def index
        render json: Course.all
    end

    def show
        render json: Course.find(course_params[:id])
    end

    def create
        course = Course.new(
            name: course_params[:name],
            code: course_params[:code],
            year: course_params[:year],
            difficulty: course_params[:difficulty]
        )

        if course.save    
            render json: course, status: :created
        else
            render json: { errors: course.errors }, status: :unprocessable_entity
        end
    end

    def update
        course = Course.find(course_params[:id])
        if course.update(course_params)
            render json: course, status: :accepted
        else
            render json: { errors: course.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        course = Course.find(course_params[:id])
        if course.destroy
            render status: :no_content
        else
            render json: {errors: course.errors}, status: :not_acceptable
        end
    end

    private

        def course_params
            params.permit(:id, :code, :year, :name, :difficulty)
        end 
end
