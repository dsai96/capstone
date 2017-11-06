json.extract! course, :id, :name, :department, :units, :description, :mini, :created_at, :updated_at
json.url course_url(course, format: :json)
