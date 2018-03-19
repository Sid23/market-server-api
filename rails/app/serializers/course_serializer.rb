class CourseSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :year, :difficulty

  def difficulty
    if object.difficulty.nil?
      # If it is not set return default value
      return 2
    else
      return object.difficulty
    end
  end
end
