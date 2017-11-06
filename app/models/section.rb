class Section < ApplicationRecord

    has_many :instructors, through: :section_instructors
    has_many :section_instructors
    has_many :students, through: :student_sections
    has_many :student_sections
    belongs_to :course

    validates_presence_of :name, :location, :building, :room, :start_time, :end_time, :days

end
