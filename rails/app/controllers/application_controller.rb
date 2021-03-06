class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions

  # Do not require user authentication for actions managed by devise
  before_action :authenticate_api_user!, unless: :devise_controller?, except: :root
  # Allow custom parameters for devise controller
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Load role based abilities defined into models/ability.rb (CanCanCan Gem)
  load_and_authorize_resource unless: :devise_controller?, except: [:root, :not_found, :current_ability, :record_not_found]

  # Defininition of custom methods for different exceptions
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from CanCan::AccessDenied, :with => :unauthorized_action

  def root 
    render json: {}, status: :ok
  end  

  def not_found
    render json: {error: "Endpoint not found."}, status: :not_found
  end

  def record_not_found
    render json: {error: "Record not found."}, status: :not_found
  end

  def unauthorized_action
    render json: {error: "Action not authorized."}, status: :forbidden
  end

  def current_ability
    @current_ability ||= Ability.new(current_api_user)
  end

  # Same as visibility of private but could be inherited
  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname])
    end
end
