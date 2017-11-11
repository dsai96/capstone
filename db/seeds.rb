# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])


require 'rubygems'
require 'json/pure'

def getAllCourses
	contents = File.open("db/s18.csv", "r"){ 
		|file| file.read 
	}

	all_courses = JSON.parse(contents)
	return all_courses
end

def createSemesters
	Semester.create(season: 'Spring', year: 2018)
end

def createSections course, sections

	days = {
		0 => 'U',
		1 => 'M',
		2 => 'T',
		3 => 'W',
		4 => 'R',
		5 => 'F',
		6 => 'S'
	}

	sections.each do |sec|

		section = Section.new
		section.course = course
		section.name = sec["name"]
		section.location = sec["times"][0]["location"]
		section.building = sec["times"][0]["building"]
		section.room = sec["times"][0]["room"]
		section.start_time = sec["times"][0]["begin"] ? sec["times"][0]["begin"].to_time : nil
		section.end_time = sec["times"][0]["end"] ? sec["times"][0]["end"].to_time : nil
		section.days = sec["times"][0]["days"] ? sec["times"][0]["days"].inject(" ") { |sum, day| sum + days[day] } : nil
		section.save!

		instructors = sec["instructors"]
		instructors.each do |i|
			names = i.split(",")
			existing_instructor = Instructor.where(fname: names[1], lname: names[0])
			if existing_instructor.empty?
				instructor = Instructor.create(fname: names[1], lname: names[0])
			else
				instructor = existing_instructor.first
			end 

			SectionInstructor.create(section: section, instructor: instructor)

		end

	end

end

def createCourses
	all_courses = getAllCourses()

	# create 2988 Course objects
	all_courses["courses"].each do |course_code, data|
		
		course = Course.new
	    course.code = course_code
	    course.name = data["name"]
	    course.department = data["department"]
	    course.units = data["units"]
	    course.description = data["desc"]
	    course.mini = 0
	    course.save!

	    createSections(course, data["sections"])
	end
end

def createCourseSemesters
	@sem = Semester.first

	Course.all.each do |course|
		CourseSemester.create(semester: @sem, course: course)
	end

end

def createMajors
	Major.create(name: 'Information Systems')
end

def createRequirements
	requirements = [
		["Mathematics and Statistics 1", "C", 28],
		["Mathematics and Statistics 2", "C", 28],
		["Mathematics and Statistics 3", "C", 28],
		["Computer Science", "C", 32],
		["Professional Core", "C", 51],
		["Professional Core Elective", "C", 6],
		["Professional Communications", "C", 9],
		["Quantitative Analysis and Research Methods", "C", 9],
		["Organizations, Policy, and Social Science", "C", 9],
		["Business/Enterprise Systems", "C", 27],
		["Computing and Information Systems & Technology", "C", 27],
		["Social and Global Systems", "C", 27],
		["Quantitative Analysis", "C", 27],
		["IDeATe", "C", 27],
	]

	requirements.each do |name, grade, units|
		Requirement.create( name: name, grade_required: grade, units: units )
	end
end

def createRequirementMajors
	@major = Major.first

	Requirement.all.each do |req|
		RequirementMajor.create(requirement: req, major: @major)
	end
end

def createCourseRequirements

	course_requirements = {
		"Mathematics and Statistics 1": ["21-111", "21-112", "36-201"],
		"Mathematics and Statistics 2": ["21-120", "21-256", "36-201"],
		"Mathematics and Statistics 3": ["21-120", "21-122", "36-201"],
		"Computer Science": ["15-110", "15-112", "15-121"],
		"Professional Core": ["67-250", "67-262", "67-272", "67-373", "67-475"],

		"Professional Core Elective": ["19-402", "19-403", "67-240", "67-279", "67-306", "67-308", "67-319", "67-324", 
			"67-327", "67-328", "67-329", "67-344", "67-353", "67-364", "67-442", "88-223", "88-275"],

		"Professional Communications": ["05-341", "36-315", "51-261", "51-262", "70-321", "70-340", "70-341", 
			"70-342", "76-270", "76-272", "85-341"],

		"Quantitative Analysis and Research Methods": ["21-257", "21-325", "36-202", "36-208", "36-217", "36-225", 
			"36-303", "36-309", "67-364", "80-305", "80-405", "88-223", "88-251", "88-275"],

		"Organizations, Policy, and Social Science": ["19-211", "15-390", "70-421", "19-402", "19-403", "19-411", 
			"67-308", "67-321", "67-344", "67-353", "70-311", "70-318", "70-332", "88-341", "70-342", "70-414", 
			"70-415", "70-416", "70-420", "70-437", "80-341", "88-223", "88-260", "88-275"],

		"Business/Enterprise Systems": ["19-402", "19-403", "67-240", "67-279", "67-306", "67-308", "67-319", "67-324", 
			"67-328", "67-330", "67-344", "67-353", "67-442", "70-318", "70-332", "70-366", "70-371", "70-414", 
			"70-437", "70-438", "70-443", "70-449", "70-455", "70-460", "70-471", "73-359", "73-469", "76-391", "76-487"],

		"Computing and Information Systems & Technology": ["05-391", "05-410", "05-430", "05-431", "05-432", "05-433", 
			"05-499", "16-311", "16-362", "19-411", "60-415", "67-240", "67-327", "67-328", "67-364", "67-442"],

		"Social and Global Systems": ["19-402", "19-403", "19-411", "67-319", "67-321", "67-329", "67-330", "67-353", 
			"70-342", "70-365", "70-430", "70-480", "73-372", "76-318", "76-386", "79-318", "79-381", "88-371", "88-384", 
			"88-411"],

		"Quantitative Analysis": ["21-257", "21-292", "36-208", "36-217", "36-303", "36-309", "36-350", "36-401", 
			"36-410", "67-364", "70-460", "70-462", "73-274", "73-374", "88-223", "88-251"],

		"IDeATe": ["62-150", "60-223", "16-223"]
	}

	course_requirements.each do |name, courses|
		# puts name, courses
		@req = Requirement.where(name: name).first
		courses.each do |code|
			@course = Course.where(code: code)
			if not @course.empty?
				CourseRequirement.create(course: @course.first, requirement: @req)
			end
		end
	end

end

createSemesters()
createCourses()
createCourseSemesters()
createMajors()
createRequirements()
createRequirementMajors()
createCourseRequirements()



