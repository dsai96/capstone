require 'rails_helper'

RSpec.describe "StudentSections", type: :request do
  describe "GET /student_sections" do
    it "works! (now write some real specs)" do
      get student_sections_path
      expect(response).to have_http_status(200)
    end
  end
end
