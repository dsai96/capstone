class CourseDependent < ApplicationRecord

    belongs_to :course
    belongs_to :dependent 

end
