class HomeController < ApplicationController
  def index
  	@requirements = Requirement.all
  end
end
