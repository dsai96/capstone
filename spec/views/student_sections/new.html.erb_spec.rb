require 'rails_helper'

RSpec.describe "student_sections/new", type: :view do
  before(:each) do
    assign(:student_section, StudentSection.new())
  end

  it "renders new student_section form" do
    render

    assert_select "form[action=?][method=?]", student_sections_path, "post" do
    end
  end
end
