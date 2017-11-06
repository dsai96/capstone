require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  require 'shoulda/matchers'

  Shoulda::Matchers.configure do |config|
  config.integrate do |with|
  with.test_framework :rspec
  with.library :rails
  end
  end

end
