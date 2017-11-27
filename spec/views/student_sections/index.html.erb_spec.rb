require 'rails_helper'

RSpec.describe "student_sections/index", type: :view do
  before(:each) do
    assign(:student_sections, [
      StudentSection.create!(),
      StudentSection.create!()
    ])
  end

  it "renders a list of student_sections" do
    render
  end
end
