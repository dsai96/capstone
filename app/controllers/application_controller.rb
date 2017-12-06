class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception
  	before_action :get_added_courses
 	include SessionsHelper


	def get_added_courses
		if logged_in?
			@student = current_student
			@sections = StudentSection.where(student: @student, added: true)
			@added_courses = []

			@sections.each do |sec|
				unless @added_courses.include? sec.section.course
					@added_courses.push(sec.section.course)
				end
			end
		end
	end

	def add_course_to_list

		if logged_in?
			@student = current_student
			secs = Section.where(course: params[:course])

			secs.each do |s|
				ss = StudentSection.new
				ss.student = @student
				ss.section = s
				ss.added = true
				ss.save!
			end

			@sections = StudentSection.where(student: @student, added: true)
			@added_courses = []

			@sections.each do |sec|
				unless @added_courses.include? sec.section.course
					@added_courses.push(sec.section.course)
				end
			end
		end

	    respond_to do |format|
	      	format.js { render :template => "student_sections/add_course_to_list" }
	    end
  	end

  	def delete_added_section

		if logged_in?
			@student = current_student
			secs = Section.where(course: params[:course])

			secs.each do |s|
				ss = StudentSection.where(student: @student, section: s)
				ss.destroy_all
			end

			@sections = StudentSection.where(student: @student, added: true)
			@added_courses = []

			@sections.each do |sec|
				unless @added_courses.include? sec.section.course
					@added_courses.push(sec.section.course)
				end
			end

   			# @colors = ['#CD5C5C', '#6e7bb2', '#6fa397']
    		# @added_student_sections = StudentSection.where(student_id: @student.id).map { |ss| [ss.section, ss.section.course.code, @colors[ss.section.course.id%3]] }
		end

	    respond_to do |format|
	      	format.js { render :template => "student_sections/add_course_to_list" }
	    end

  	end

end
