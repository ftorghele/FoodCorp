require "test_helper"
require "capybara/rails"

module ActionController
  class IntegrationTest
    include Capybara

    def sign_in_as(email, password)
      user = User.create( :password => password,
                          :password_confirmation => password,
                          :email => email,
                          :first_name => "Hans",
                          :last_name => "Testuser",
                          :gender => "male")
      user.confirm!
      user.save!

      visit '/'
      fill_in 'user_email', :with => email
      fill_in 'user_password', :with => password

      click_on("Sign in")
    end
    def sign_out
      click_link "Logout"
    end
  end
end
