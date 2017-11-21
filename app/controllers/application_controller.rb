class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

  	@student = Student.first
	all_sections = StudentSection.where(student: @student)
    @divya = [Course.first]
    all_sections.each do |s|
      unless @divya.include?(s.section.course)
        @divya.push(s.section.course)
      end
    end

    puts @divya.size
end
