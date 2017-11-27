require 'rails_helper'

RSpec.describe "student_sections/edit", type: :view do
  before(:each) do
    @student_section = assign(:student_section, StudentSection.create!())
  end

  it "renders the edit student_section form" do
    render

    assert_select "form[action=?][method=?]", student_section_path(@student_section), "post" do
    end
  end
end
