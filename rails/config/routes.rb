# Used to manage API versioning and remove version from url
require 'api_constraints'

Rails.application.routes.draw do
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'application#root'

    # Reset password
    get 'reset_password', controller: :pages

    # Api definition, it maps routes to controllers into controllers/api, set the data format as JSON and set this path as root (host/api)
    namespace :api, defaults: { format: :json }, path: '/' do
        
        # Scope APIs in different versions of them, the version 1 is the default one
        scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
            # User authentication routes
            mount_devise_token_auth_for 'User', at: 'auth'
            
            resources :users, :only => [:index, :create, :show, :update, :destroy]
            resources :admins, :only => [:index, :show, :update, :destroy]

            resources :courses, :only => [:index, :show, :create, :update, :destroy]
        end   
    end

  #  Action cable
  mount ActionCable.server => '/cable'

  # If no route matches avoid routing errors
  #get ":url" => "application#not_found", :constraints => { :url => /.*/ }

end
