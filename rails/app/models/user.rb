class User < ActiveRecord::Base
    
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
end