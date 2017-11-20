require "rails_helper"

RSpec.describe StudentSectionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/student_sections").to route_to("student_sections#index")
    end

    it "routes to #new" do
      expect(:get => "/student_sections/new").to route_to("student_sections#new")
    end

    it "routes to #show" do
      expect(:get => "/student_sections/1").to route_to("student_sections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/student_sections/1/edit").to route_to("student_sections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/student_sections").to route_to("student_sections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/student_sections/1").to route_to("student_sections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/student_sections/1").to route_to("student_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/student_sections/1").to route_to("student_sections#destroy", :id => "1")
    end

  end
end
