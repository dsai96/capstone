class Course < ApplicationRecord

	after_initialize :set_defaults
  
	has_many :sections
	has_many :course_dependents
	has_many :dependents, through: :course_dependents
	has_many :course_requirements
	has_many :requirements, through: :course_requirements
	has_many :course_semesters
	has_many :semesters, through: :course_semesters
	validates_presence_of :code, :name, :mini

	def set_defaults
    	# Only set if time_zone IS NOT set
    	self.department ||= " "
    	self.units ||= 0.0
    	self.description ||= " "

  	end

end
