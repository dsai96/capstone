class Course < ApplicationRecord

  has_many :sections
  has_many :course_dependents
  has_many :dependents, through: :course_dependents
  has_many :course_requirements
  has_many :requirements, through: :course_requirements
  has_many :course_semesters
  has_many :semesters, through: :course_semesters
  validates_presence_of :name, :department, :units, :description, :mini

end
