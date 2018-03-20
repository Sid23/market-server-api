class Subscription < ApplicationRecord

    belongs_to :user
    belongs_to :course

    # Do not duplicate User subscription to a course
    validates :course_id, uniqueness: { scope: :user_id, message: "User already subscribed to this course!" }

end
