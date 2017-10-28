json.extract! student, :id, :fname, :lname, :email, :created_at, :updated_at
json.url student_url(student, format: :json)
