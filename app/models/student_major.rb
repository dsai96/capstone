class StudentMajor < ApplicationRecord

  belongs_to :student
  belongs_to :major

end
