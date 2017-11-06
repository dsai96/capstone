require 'test_helper'

class SemesterTest < ActiveSupport::TestCase

  should validate_presence_of(:season)
  should validate_presence_of(:year)
  should allow_value("F").for(:season)
  should_not allow_value("2017").for(:year)

end
