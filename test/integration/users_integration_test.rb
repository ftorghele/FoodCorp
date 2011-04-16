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
    click_on("Logout")
  end
  
  def provide_meal
    visit '/users/1'  
    login()
    click_on("provide meal")
    assert page.has_css?('div#provide_meal', :count => 1)
    assert page.has_css?('form', :count => 1)
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
    y save_and_open_page
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
    
    visit '/users/1'
    assert page.has_no_css?('#calendar')
    assert page.has_css?('h1#profile_name', :count => 1)
    
    login()
    
    visit '/users/1'
    assert page.has_css?('div#calendar', :count => 1)
    assert page.has_css?('h1#profile_name', :count => 1)
    assert page.has_css?('img#profile_avatar', :count => 1)
    assert page.has_css?('a#provide_meal_button', :count => 1)
    
    logout()
  end 
  
  should "user should not be able to create new meal without filling all relevant fields" do
    provide_meal()
    
    #1unsigned please fill in the following fields
    click_on("Submit")
    click_on("OK")
    #2 please fill in the following fields
    fill_in 'Dish', :with => "Gulasch"
    fill_in 'Dish description', :with => "scharf und mit Knödel"
    click_on("Submit")
    click_on("OK")
    #3 please check your location
    fill_in 'Dish', :with => "Gulasch"
    fill_in 'Dish description', :with => "scharf und mit Knödel"
    fill_in 'Address', :with => "5020 Siegmund Hafner Gasse 10"
    fill_in 'Date and Time', :from => "2011-04-15T20:00Z"
    fill_in 'Deadline', :with => "2011-04-15T16:00Z"
    click_on("Submit")
    click_on("OK")
    #4 please check your location
    fill_in 'Dish', :with => ""
    fill_in 'Dish description', :with => "scharf und mit Knödel"
    fill_in 'Address', :with => "5020 Siegmund Hafner Gasse 10"
    fill_in 'Date and Time', :from => "2011-04-15T20:00Z"
    fill_in 'Deadline', :with => "2011-04-15T16:00Z"
    click_on('check your location')
    click_on("Submit")
    click_on("OK")
  end
  
  should "user should be able to create new meal" do
    provide_meal()
    
    fill_in 'Dish', :with => "Gulasch"
    fill_in 'Dish description', :with => "scharf und mit Knödel"
    ##
    fill_in 'Address', :with => "5020 Siegmund Hafner Gasse 10"
    fill_in 'Date and Time', :from => "2011-04-15T20:00Z"
    fill_in 'Deadline', :with => "2011-04-15T16:00Z"
    
    click_on("check your location")
    
    assert_difference("Meal.count") do
      click_on("Submit")    
    end
    assert page.has_content?('meal created successfully')
  end
  
  
  should "user should be able to see meal information" do
    visit '/meals/1'
    
    assert page.has_css?('div#meal_show', :count => 1)
    assert page.has_content?('Gulasch')
    assert page.has_content?('scharf und mit Knödel')
    assert page.has_content?('5020 Siegmund Hafner Gasse 10')
    
    assert_not_nil(@meal.lon) #?
    assert_not_nil(@meal.lat) #?
  end
end
