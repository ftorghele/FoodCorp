# coding: UTF-8

require 'test_integration_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  
  def create_meal
    fill_in 'Title', :with => 'Gulasch'
    fill_in 'Description', :with => 'scharf und mit Knödel'
    fill_in 'Country', :with => 'Austria'
    fill_in 'City', :with => 'Salzburg'
    fill_in 'Zip code', :with => '5020'
    fill_in 'Street', :with => 'Getreidegasse'
    fill_in 'Street number', :with => '3'
    select '3', :from => 'Slots'
    fill_in 'Time', :with => Time.zone.at(Time.now.to_datetime.to_i+100).to_formatted_s(:db)
    fill_in 'Deadline', :with => Time.zone.at(Time.now.to_datetime.to_i+1000).to_formatted_s(:db)

    page.find('#meal_lat').set('34.00000000')
    page.find('#meal_lon').set('34.00000000')

    assert_difference("Meal.count") do
      click_on("submit")
    end
  end

  def login_user user_number 
    click_on('Login')
    fill_in 'user_email', :with => 'user'+user_number+'@gmail.com'
    fill_in 'user_password', :with => '123456'
    click_on('Sign in')
  end

  def check_design args
    assert page.has_css?('div#logo', :count => 1)
    assert page.has_css?('ul#topnav', :count => 1)
    args.each do |content|
        assert page.has_content?(content)
    end
  end

  def visit_last_meal 
    meal = Meal.last
    visit '/meals/'+ meal.id.to_s
  end

  should "show facebook sign in page" do
    visit '/'
    # checking the html structure
    assert page.has_css?('a#fb_sign_in', :count => 1)
    click_on("Login in with Facebook") 
    #assert page.has_content?('Make Together')
  end
    
  should "user should be able to visit his/her profile" do
    sign_in_as("user1@gmail.com", "123456")

    click_on('Hans Testuser')
    assert page.has_css?('h3', :count => 1)
    
    sign_out
  end

  should "be able to create new meal send request for meal and accept request" do

    sign_in_as("user1@gmail.com", "123456")

    click_on('cook')
    click_on('new meal')
    assert page.has_css?('form', :count => 1)

    click_on("submit")
    assert_not_same("1","Meal.count")
    
    create_meal

    assert page.has_content?('Meal successfully saved!')

    click_on('Hans Testuser')
    click_on('meals')
    assert page.has_content?('Gulasch')
    sign_out

    #check created Meal
    visit '/'
    assert page.has_css?('div#mealfind', :count => 1)
    assert page.has_css?('div#map', :count => 1)

    #create Meal Arrangement
    sign_in_as("user2@gmail.com", "123456")
    meal = Meal.last
    visit '/meals/'+ meal.id.to_s
    click_on('request_meal')

    assert page.has_content?('Meal arrangement was successfully created')
    assert page.has_css?('form', :count => 2)
    click_on('delete_meal_request')

    assert page.has_content?('Meal arrangement was successfully deleted')
    click_on('request_meal')
    sign_out

    login_user "1"
    click_link('cook')
    click_link('meals')
    click_on('Accept')
    sign_out

    login_user "2"
    click_on('personal Messages')
    assert page.has_content?('Meal arrangement acceptance')
    sign_out
  end

  should "be able to delete meal request" do

    sign_in_as("user1@gmail.com", "123456")

    check_design ["You are in", "Radius:" , "Date:"]

    click_link('cook')
    click_on('new meal')
    create_meal
    sign_out

    sign_in_as("user2@gmail.com", "123456")
    visit_last_meal
    click_on('request_meal')
    sign_out

    login_user "1" 
    click_link('Hans Testuser')
    click_on('Delete')
    sign_out

    login_user "2"
    click_on('personal Messages')
    assert page.has_content?('Meal arrangement rejected')
    sign_out   
  end

  should "be able to edit meal" do
    sign_in_as("user1@gmail.com", "123456")
                   
    click_on('cook')
    click_on('new meal')
    create_meal
    click_link('Edit_meal')

    fill_in 'Title', :with => 'Gulasch'
    fill_in 'Description', :with => 'doch nicht scharf und ohne Knödel'
    click_on('submit')
    check_design ['doch nicht scharf und ohne Knödel', 'Gulasch']
  end

  should "be able to create comment" do
    sign_in_as("user1@gmail.com", "123456")
    click_link('cook')
    click_on('new meal')
    create_meal

    fill_in 'body', :with => 'Supa woas'
    click_on('comment_submit')
    #check_design ['Supa woas', 'user1']
    sign_out

    sign_in_as("user2@gmail.com", "123456")
    visit '/'

    visit_last_meal
    fill_in 'body', :with => 'MHM'
    click_on('comment_submit')
    sign_out
  end

  should "be able to follow other user" do
    sign_in_as("user1@gmail.com", "123456")

    click_on('cook')
    click_on('new meal')
    create_meal
    sign_out

    sign_in_as("user2@gmail.com", "123456")
    visit_last_meal
    click_link('Follow')
    check_design ["following..."]
    click_link('Unfollow')
    check_design ["Removed fellowship"]
    save_and_open_page



  end
    
end