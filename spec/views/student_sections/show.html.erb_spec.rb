require 'rails_helper'

RSpec.describe "student_sections/show", type: :view do
  before(:each) do
    @student_section = assign(:student_section, StudentSection.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
