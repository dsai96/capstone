class Instructor < ApplicationRecord

  has_many :sections, through: :section_instructors
  has_many :section_instructors
  validates_presence_of :fname, :lname

end
