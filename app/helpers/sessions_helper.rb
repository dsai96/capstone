module SessionsHelper

  def log_in(student)
    session[:student_id] = student.id
  end

  # Returns the current logged-in user (if any).
  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def logged_in?
    current_student
    !current_student.nil?
  end
end
