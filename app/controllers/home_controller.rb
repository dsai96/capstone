class HomeController < ApplicationController
  include SessionsHelper
  def index
  	@requirements = Requirement.alphabetical
  	@current_student = current_student
  	
  end
end
