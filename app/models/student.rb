class Student < ApplicationRecord

  has_many :students, through: :student_sections
  has_many :student_sections

  has_many :majors, through: :student_majors
  has_many :student_majors
  validates_presence_of :fname, :lname, :email

end
