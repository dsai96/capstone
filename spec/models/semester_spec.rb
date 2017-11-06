require 'rails_helper'

RSpec.describe Semester, type: :model do
  it "has a valid factory" do
    semester = FactoryGirl.create(:semester)
    expect(semester).to be_valid
  end

  describe Semester do
  it { is_expected.to validate_presence_of(:season) }
  it { is_expected.to validate_presence_of(:year) }
  end

end
