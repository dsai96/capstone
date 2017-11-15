class HomeController < ApplicationController
  def index
  	@requirements = Requirement.alphabetical
  end
end
