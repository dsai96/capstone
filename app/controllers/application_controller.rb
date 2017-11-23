class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception
  	before_action :get_added_courses

	def get_added_courses
		@test = [1,2,3,4]
	end

	def add_course_to_list
		puts "hello"
	    @test = Array.new(4) { rand(1...9) }
	    respond_to do |format|
	      	format.js { render :template => "student_sections/add_course_to_list" }
	    end
  	end

end
