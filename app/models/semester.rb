class Semester < ApplicationRecord

  has_many :course_semesters
  has_many :courses, through: :course_semesters

  validates_presence_of :season, :year

  scope :chronological,		-> { order("year", "season") }

  def title
    season + year.to_s
  end
  
end
