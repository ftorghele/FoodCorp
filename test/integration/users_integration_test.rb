require 'test_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  should "show facebook sign in page" do
    visit '/'
    # checking the html structure
    assert page.has_css?('a#fb_sign_in', :count => 1)
    click_button "Sign in with facebook"
    #assert page.has_content?('Make Together')
  end

  should "create user" do
    visit '/'
    click_link "Register"
    
    fill_in "e-mail", :with => "test@testuser.com"
    fill_in "zip_code", :with => "5412"
    fill_in "adress", :with => "Puch"
    fill_in "country", :with => "Austria"
    fill_in "street", :with => "Urstein Süd"
    fill_in "street_number", :with => "1"
    #fill_in "door_number", :with => "666"
    fill_in "first_name", :with => "Hans"
    fill_in "last_name", :with => "Testuser" 
    fill_in "gender", with => "Male"
    
    assert_difference("User.count") do
      click_button "Sign up"
    end

    assert page.has_css?('#user_name', :count => 1)
    assert page.has_content?('Hans Testuser')
    
    click_link "Logout"
    assert page.has_content?('Signed out successfully')
  end
    
end
