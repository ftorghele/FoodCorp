# coding: UTF-8

require 'test_integration_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  
  should "show facebook sign in page" do
    #visit '/'
    # checking the html structure
    #assert page.has_css?('a#fb_sign_in', :count => 1)
    #click_button "Sign in with facebook"
    #assert page.has_content?('Make Together')
  end
    
  should "user should be able to visit his/her profile" do
    sign_in_as("user1@gmail.com", "123456")

    click_on('Profile')
    assert page.has_css?('h1#profile_name', :count => 1)
    
    sign_out
  end

  should "be able to create new meal" do

    sign_in_as("user1@gmail.com", "123456")

    click_on('Profile')
    click_on('provide meal')
    assert page.has_css?('form', :count => 1)

    click_on("submit")
    assert_not_same("1","Meal.count")
    
    fill_in 'Title', :with => 'Gulasch'
    fill_in 'Description', :with => 'scharf und mit Knödel'
    fill_in 'Country', :with => 'Austria'
    fill_in 'City', :with => 'Salzburg'
    fill_in 'Zip code', :with => '5020'
    fill_in 'Street', :with => 'Getreidegasse'
    fill_in 'Street number', :with => '3'
    fill_in 'Time', :with => '2011-04-15T20:00Z'
    fill_in 'Deadline', :with => '2011-04-15T16:00Z'

    page.find('#meal_lat').set('34.00000000')
    page.find('#meal_lon').set('34.00000000')

    assert_difference("Meal.count") do
      click_on("submit")
    end

    assert page.has_content?('meal created successfully')
    sign_out

    visit '/'
    assert page.has_css?('div#meals_distance_stream', :count => 1)
    assert page.has_css?('div.meal', :count => 1)

    assert page.has_content?('Gulasch')
    assert page.has_content?('scharf und mit Knödel')

    sign_in_as("user2@gmail.com", "123456")

    click_on('Gulasch scharf und mit Knödel')
    click_on('send meal request')

    assert page.has_content?('Meal arrangement was successfully created.')
    assert page.has_css?('form', :count => 1)
    click_on('delete meal request')

    assert page.has_content?('Meal arrangement was successfully deleted.')
    
    sign_out
  end
    
end