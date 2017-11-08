namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    require 'factory_girl_rails'

    # Step 0: drop old databases and rebuild
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:test:prepare'].invoke
    
    # Step 1: Add 10 Requirements
    10.times do |i|
        req = Requirement.new
        req.name = Faker::App.name
        req.grade_required = 4
        req.save!
    end
    
    # Step 2: Add 20 courses with assigned reqs
    req_ids = Requirement.all.map(&:id)
    20.times do |i|
      c =  Course.new
      c.name = Faker::Team.name
      c.department = ["Computer Science", "Information Systems", "Business Administration", "Human-Computer Interaction", "Chemical Engineering"].sample
      c.units = [3, 6, 9, 10, 12].sample
      c.description = "Course description that thoroughly describes this course using many words and rhetoric to give the student a better understanding of what they can expect from this course."
      c.mini = 0
      c.save!
      
      cr = CourseRequirement.new
      cr.course_id = c.id
      cr.requirement_id = req_ids.sample
      cr.save!
    end
    
    # Step 3: Add fall and spring semesters
    s_fall = Semester.new
    s_fall.season = "Fall"
    s_fall.year = 2017
    s_fall.save!
    
    s_spring = Semester.new
    s_spring.season = "Spring"
    s_spring.year = 2018
    s_spring.save!
    
    # Step 4: Add 20 CourseSemesters
    course_ids = Course.all.map(&:id)
    semester_ids = Semester.all.map(&:id)
    course_ids.each do |c_id|
        cs = CourseSemester.new
        cs.semester_id = semester_ids.sample
        cs.course_id = c_id
        cs.save!
    end
    
    # Step 5: Create 40 Sections (2 per course)
    eleven_thirty = DateTime.new(2017, 2, 17, 11, 30)
    twelve_twenty = DateTime.new(2017, 2, 17, 12, 20)
    twelve_thirty = DateTime.new(2017, 2, 17, 12, 30)
    one_twenty = DateTime.new(2017, 2, 17, 13, 20)
    one_thirty = DateTime.new(2017, 2, 17, 13, 30)
    two_twenty = DateTime.new(2017, 2, 17, 14, 20)
    two_thirty = DateTime.new(2017, 2, 17, 14, 30)
    three_twenty = DateTime.new(2017, 2, 17, 15, 20)
    start_times = [eleven_thirty, twelve_thirty, one_thirty, two_thirty]
    end_times = [twelve_twenty, one_twenty, two_twenty, three_twenty]
    course_ids.each do |c_id|
        2.times do |i|
            section = Section.new
            section.course_id = c_id
            section.name = (i == 0) ? "A" : "B"
            section.location = "Pittsburgh, Pennsylvania"
            section.building = ["SH", "PH", "BH", "DH", "CFA"].sample
            section.room = [*15..350].to_a.sample
            time_index = [*0..3].sample
            section.start_time = start_times[time_index]
            section.end_time = end_times[time_index]
            section.days = [[1, 3, 5], [2, 4]].sample
            section.save!
        end
    end
    
    # Step 6: Create 20 Instructors, 40 SectionInstructors
    course_ids.each do |course_id|
        i = Instructor.new
        i.fname = Faker::Name.first_name
        i.lname = Faker::Name.last_name
        i.save!
        
        course = Course.find(course_id)
        course.sections.each do |s|
            si = SectionInstructor.new
            si.instructor_id = i.id
            si.section_id = s.id
            si.save!
        end
    end
    
    # Step 7: Add 5 Majors with 3 assigned requirements
    majors = ["Information Systems", "Computer Science", "Business Administration", "Chemical Engineering", "Art"]
    majors.each do |m_name|
        major = Major.new
        major.name = m_name
        major.save!
        
        req_ids = Requirement.all.map(&:id)
        3.times do |i|
            rm = RequirementMajor.new
            rm.major_id = major.id
            rm.requirement_id = req_ids.sample
            req_ids.delete(rm.requirement_id)
            rm.save!
        end
    end
    
    # Step 8: Add 100 Students and assign them to a major
    major_ids = Major.all.map(&:id)
    100.times do |i|
        student = Student.new
        student.fname = Faker::Name.first_name
        student.lname = Faker::Name.last_name
        student.email = student.fname + student.lname + "@gmail.com"
        student.save!
        
        sm = StudentMajor.new
        sm.student_id = student.id
        sm.major_id = major_ids.sample
        sm.save!
    end
    
    # Step 9: Add 500 StudentSections (5 per student)
    student_ids = Student.all.map(&:id)
    student_ids.each do |s_id|
        section_ids = Section.all.map(&:id)
        5.times do |i|
            ss = StudentSection.new
            ss.student_id = s_id
            ss.section_id = section_ids.sample
            section_ids.delete(ss.section_id)
            ss.saved = false
            if ([1,2].sample == 1)
                ss.added = true
                ss.registered = true
                ss.completed = false
            else
                ss.added = false
                ss.registered = false
                ss.completed = true
                ss.grade_recieved = [*0..4].to_a.sample
            end
            ss.save!
        end
    end

  end
end