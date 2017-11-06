class Semester < ApplicationRecord

  has_many :course_semesters
  has_many :courses, through: :course_semesters

  validates_presence_of :season, :year

  def title
    season + year.to_s
  end
  
end
