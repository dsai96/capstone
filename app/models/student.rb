class Student < ApplicationRecord

  has_many :students, through: :student_sections
  has_many :student_sections

  has_many :majors, through: :student_majors
  has_many :student_majors
  validates_presence_of :fname, :lname, :email, :password
  validates_format_of :email, :with => /.*@andrew.cmu.edu/, :on => :create
  validates_uniqueness_of :email
  validates :password, length: { minimum: 6 }

  has_secure_password


end
