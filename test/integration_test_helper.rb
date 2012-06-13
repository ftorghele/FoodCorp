require "test_helper"
require "capybara/rails"


module ActionController
  class IntegrationTest
    include Capybara

    def sign_in_as(first_name, last_name, email, password)
      @user = FactoryGirl.create(:user)
      @user.first_name = first_name
      @user.last_name = last_name
      @user.email = email
      @user.password = password
      @user.confirm!
      @user.save!

      visit root_path
	  click_link 'Login'
	  fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      click_on('user_submit')
      
      @user
    end
    
    def sign_out
      click_link "Logout"
    end
  end
end
