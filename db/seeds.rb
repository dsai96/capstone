# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])


require 'rubygems'
require 'json/pure'

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
end

contents = File.open("db/out.csv", "r"){ 
	|file| file.read 
}

all_courses = JSON.parse(contents)

is_courses = []
all_courses["courses"].each do |course, data|
	if course.index("67-") == 0 
		is_courses << course
	end
end

puts is_courses


