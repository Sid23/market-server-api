class Api::V1::Users::CoursesController < ApplicationController

    # Skip authorization rules defined into abiliti.rb
    # All methods here have to include custom controls for authorizations !!!
    skip_load_and_authorize_resource

    def index
        # Avoid User to index courses of another user
        if current_api_user.id.to_s == params[:user_id] || current_api_user.admin?
            # Only list courses where current user is subscribed
            user = User.find(params[:user_id])
            render json: user.courses.all
        else
            unauthorized_action()
        end
    end

    def create
        
        # This action can be executed only by Admins or by User specified into :user_id parameter
        # Avoid User to subscribe other user
        if current_api_user.id.to_s == params[:user_id] || current_api_user.admin?

            # There is a :record-not_found method into application controlled that mathch record not found exception
            user = User.find(params[:user_id])
            
            # Only Admin can create courses, so check if a courses is already saved into db
            if params.has_key?(:id)
                course = Course.find(params[:id])

            elsif params.has_key?(:code) && params.has_key?(:year)
                # Alternative way to find a course
                course = Course.find_by(code: params[:code], year: params[:year])

            else
                # Impossible to find existing course
                unauthorized_action()
                return
            end

            # Do not save the couse into Course table but just add an entry into table subscription!
            if user.courses << course
                render json: course, status: :created
            else
                render json: { errors:course.errors }, status: :unprocessable_entity
            end
        
        else
            unauthorized_action()
        end
    end

    private

        def course_params
            params.permit(:code, :year, :id)
        end
end