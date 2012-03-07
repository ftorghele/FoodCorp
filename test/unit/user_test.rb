require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.

    should "not be able to create User account without password" do
      user = User.new(:name => "tester", :email => "tester@gmail.com")
      user.save

      assert !user.valid?, user.errors.to_s
    end

    should "not be able to create User account without e-mail" do
      user = User.new(:name => "tester", :password => "fffffff" , :password_confirmation => "fffffff")
      user.save

      assert !user.valid?, user.errors.to_s
    end
end
