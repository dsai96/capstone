require 'rails_helper'

RSpec.describe Student, type: :model do
  it "has a valid factory" do
    student = FactoryGirl.create(:student)
    expect(student).to be_valid
  end

  describe Student do
  it { is_expected.to validate_presence_of(:fname) }
  it { is_expected.to validate_presence_of(:lname) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { should validate_length_of(:password).is_at_least(6) }
  it { should_not allow_value("b lah").for(:email) }
  it { should allow_value("s@andrew.cmu.edu").for(:email) }

  it 'does not create when email is bad' do
      student = Student.new(email: "said@gmail.com")
      student.valid?
      expect(student.errors[:email].size).to eq(1)
    end

  end

end
