class SessionsController < ApplicationController
  include SessionsHelper
  layout 'nologin'
  def new
  end

  def create
    student = Student.find_by(email: params[:session][:email])
        if student && student.authenticate(params[:session][:password])
          log_in student
          redirect_to home_path
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
