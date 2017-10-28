json.extract! instructor, :id, :fname, :lname, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)
