class Section < ApplicationRecord

    has_many :instructors, through: :section_instructors
    has_many :section_instructors
    validates_presence_of :fname, :lname


end
