class Requirement < ApplicationRecord

  has_many :requirement_majors
  has_many :majors, through: :requirement_majors
  has_many :courses, through: :course_requirements
  has_many :course_requirements

  validates_presence_of :name, :grade_required

  scope :alphabetical,	-> { order("name") }

end
