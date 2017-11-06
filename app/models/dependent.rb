class Dependent < ApplicationRecord

  has_many :course_dependents
  has_many :courses, through: :course_dependents
end
