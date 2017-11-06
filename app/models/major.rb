class Major < ApplicationRecord

      has_many :student_majors
      has_many :students, through: :student_majors
      has_many :requirements, through: :requirement_majors
      has_many :requirement_majors

      validates_presence_of :name
end
