class User < ActiveRecord::Base
    
    has_many :subscriptions
    # It isd possible to access to the user courses directly by model
    has_many :courses, through: :subscriptions

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :recoverable, :timeoutable, :trackable, :validatable
    include DeviseTokenAuth::Concerns::User

    # User validation
    validates :email, presence: true, uniqueness: true
    validates :name, :surname, presence: true

    # User method used to check if a user is an admin or a member
    def admin?
        self.type == "Admin"
    end

    # Overrides Devise method to deliver with ActiveJob
    def send_devise_notification(notification, *args)
        devise_mailer.send(notification, self, *args).deliver_later
    end

    def send_welcome_mail
        UserMailer.user_welcome_mail(self.name, self.email).deliver_later
    end
end