# Custom validator for uniqueness of year and code
class CodeUniquePerYear < ActiveModel::Validator
    def validate(record)
        same_year_records = Course.select(:code).where(year: record.year)
        if same_year_records.exists?(code: record.code)
            record.errors[:code] << 'Code already saved for this year!'
        end
    end
end

class Course < ApplicationRecord
    include ActiveModel::Validations

    validates :name, presence: true, length: { maximum: 60 }
    validates :code, presence: true, length: { is: 8 }
    validates :year, presence: true, numericality: { greater_than_or_equal_to: 2010 }
    #validates :difficulty, inclusion: { in: 0..5 }

    # check the uniqueness for the couple code and year, same code may apper in different years (but not in the same)
    validates_with CodeUniquePerYear
end

