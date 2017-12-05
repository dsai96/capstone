class StudentSection < ApplicationRecord

	belongs_to :student
	belongs_to :section
	
	scope :completed,  -> { where(completed: true) }
	scope :incomplete, -> { where(completed: false).or(where(completed: nil)) }

end
