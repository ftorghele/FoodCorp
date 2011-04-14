require 'test_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  
  should "show facebook sign in page" do
    #visit '/'
    # checking the html structure
    #assert page.has_css?('a#fb_sign_in', :count => 1)
    #click_button "Sign in with facebook"
    #assert page.has_content?('Make Together')
  end
  
  OmniAuth.config.test_mode = true
  
  def login
     visit '/'
     fill_in 'user_email', :with => "test@testuser.com"
     fill_in 'user_password', :with => "blabla"
     click_on("Sign in")
  end
  
  def logout
    visit ''
    click_on("Sign out")
  end

  should "register new user" do
=begin
    visit '/'
    click_link "Register"
    
    fill_in I18n.t("activerecord.attributes.user.email"), :with => "test@testuser.com"
    fill_in "Password", :with => "blabla"
    fill_in "Password confirmation", :with => "blabla"
    fill_in "First name", :with => "Hans"
    fill_in "Last name", :with => "Testuser"
    fill_in "Country", :with => "Austria"
    fill_in "City", :with => "Puch"
    fill_in "Zip code", :with => "5800"
    fill_in "Street", :with => "Urstein Süd"
    fill_in "Street number", :with => "1"
    fill_in "Phone number", :with => "066021254323"
    select "male", :from => "Gender"
    y User.all
    assert_difference("User.count") do
      click_on("Sign up")
      User.all.confirm!
      save_and_open_page
=end
  end
  
  should "login existing user and logout after success" do

    user = User.create(:password => "blabla", 
                       :password_confirmation => "blabla", 
                       :email => "test@testuser.com",
                       :first_name => "Hans",
                       :last_name => "Testuser",
                       :country => "Austria",
                       :city => "Puch",
                       :zip_code => "8500",
                       :street => "Urstein S&uuml;d",
                       :street_number => "1",
                       :phone_number => "0660212643",
                       :gender => "male")
            
    user.confirm! 
    user.save!
    
    visit '/'
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password

    click_on("Sign in")

    assert page.has_content?('eingeloggt')
    assert page.has_content?('Hans Testuser')
    
    click_link "Logout"
    assert page.has_content?('Signed out successfully')
  end
  
  should "user should be able to visit his/her profile" do
    visit '/profile/1'
    assert page.has_css?('div#calendar', :count => 0)
    assert page.has_css?('h1#profile_name', :count => 1)
    
    login()
       
    visit '/profile/1'
    assert page.has_css?('div#calendar', :count => 1)
    assert page.has_css?('h1#profile_name', :count => 1)
    assert page.has_css?('div#profile_avatar', :count => 1)
    
    logout()
    User.all.delete!
  end 
end
