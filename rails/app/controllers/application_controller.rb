class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  # Do not require user authentication for actions managed by devise
  before_action :authenticate_api_user!, unless: :devise_controller?, except: :root
  # Allow custom parameters for devise controller
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Defininition of custom methods for different exceptions
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from CanCan::AccessDenied, :with => :unauthorized_action


  def root 
    render json: {}, status: :ok
  
  end  

  def not_found
    render json: {errors: "Endpoint not found."}, status: :not_found
  end

  def unauthorized_action(error)
    render :json => {:error => error}, :status => :not_allowed
  end


  # Same visibility of private but could be inherited
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
    end
end
