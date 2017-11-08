# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
  # Major.create(name: 'Information Systems')

# contents = File.open("snippet.txt", "r"){ |file| file.read }

require 'rubygems'
require 'json/pure'

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


