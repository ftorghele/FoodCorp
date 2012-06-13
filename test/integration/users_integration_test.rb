# coding: UTF-8

require 'test_integration_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  
  def create_meal
    fill_in 'meal_title', :with => 'Gulasch'
    fill_in 'meal_time', :with => Time.zone.at(Time.now.to_datetime.to_i+1000).to_formatted_s(:db)
    fill_in 'meal_street', :with => 'Getreidegasse'
    fill_in 'meal_street_number', :with => '3'
    fill_in 'meal_zip_code', :with => '5020'
    fill_in 'meal_city', :with => 'Salzburg'
    fill_in 'meal_country', :with => 'Austria'
   
    select '3', :from => 'meal_slots'
    fill_in 'meal_deadline', :with => Time.zone.at(Time.now.to_datetime.to_i+100).to_formatted_s(:db)
	
	check('meal_eat_in')
	check('meal_take_away')
	
	fill_in 'meal_description', :with => 'scharf und mit Knödel'
    
    check('meal_vegetarien')
   
    page.find('#meal_lat').set('34.00000000')
    page.find('#meal_lon').set('34.00000000')

    assert_difference("Meal.count") do
      click_on("meal_submit")
    end
  end
  
  def create_user
    @user = FactoryGirl.create(:user) if User.all.empty?
    @user.confirm!
    @user.save!
  end
  
  def login_user user_number
    user = User.where(:id => user_number)
    user = sign_in_as(User.first.first_name << "X", User.first.last_name << "X", "x." << User.first.email, "123456") if user.empty?
	
	visit root_path
	puts page.body
    click_on('Login')
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
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
	
  def createCurrentUserLocation user
	loc = CurrentUserLocation.new( :street_number => 0, :street => 'Pakerstreet', :zip_code => 1234, :city => "London", :country => "England" )
    loc.user_id = user.id
    loc.save
  end
  
  test "show facebook sign in page" do
    visit root_path
    click_on("fb_sign_in")
    
    assert_equal true, page.has_content?('Facebook registrieren')
  end
  
  test "user should be able to visit his/her profile" do
    sign_in_as("Mr.Test1", "test1", "user15@gmail.com", "123456")
	
    click_on('Mr.Test1 test1')
    assert page.has_css?('h3', :count => 1)
    
    sign_out
  end

  test "be able to create new meal" do

    sign_in_as("Mr.Test2", "test2", "user16@gmail.com", "123456")

    click_on('cook')
    assert page.has_css?('form', :count => 1)

    click_on("submit")
    assert_not_same("1","Meal.count")
    
    create_meal

    assert page.has_content?('Meal successfully saved!')
  end
  
  test "be able to send request for meal" do
  	
  	sign_in_as("Mr.Test3", "test3", "user3@gmail.com", "123456")
  	
    click_on('Mr.Test3 test3')
    
    assert page.has_content?('Gulasch')
    sign_out

    #check created Meal
    visit '/'
    assert page.has_css?('div#mealfind', :count => 1)
    assert page.has_css?('div#map', :count => 1)

    #create Meal Arrangement
    sign_in_as("Mr.Test4", "test4", "user4@gmail.com", "123456")
    meal = Meal.last
    visit '/meals/'+ meal.id.to_s
    click_on('request_meal')

    assert page.has_content?('Meal arrangement was successfully created')
    assert page.has_css?('form', :count => 2)
    click_on('delete_meal_request')

    assert page.has_content?('Meal arrangement was successfully deleted')
    click_on('request_meal')
    sign_out
  end
  
  test "should be able to accept a reuqest" do
    
    login_user 1
    click_link('cook')
    click_link('meals')
    click_on('Accept')
    sign_out

    login_user 2
    click_on('personal Messages')
    assert page.has_content?('accepted')
    sign_out
  end

  test "be able to delete meal request" do

    sign_in_as("Mr.Test5", "test5", "user5@gmail.com", "123456")

    check_design ["You are in", "Radius:" , "Date:"]

    click_link('cook')
  
    create_meal
    sign_out

    sign_in_as("Mr.Test6", "test6", "user6@gmail.com", "123456")
    visit_last_meal
    click_on('request_meal')
    sign_out

    login_user 1
    click_link('Hans Testuser')
    click_on('Delete')
    sign_out

    login_user 2
    click_on('personal Messages')
    assert page.has_content?('rejected')
    sign_out   
  end

  test "be able to edit meal" do
    @user = FactoryGirl.create(:user) if User.all.empty?
    @user.confirm!
    @user.save!
      
	Capybara.using_session("id") do
	  visit root_path
	  click_link 'Login'
	  fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      click_on('user_submit')
          
	  click_on('cook')
      
	  create_meal
	  click_link('Edit_meal')

	  fill_in 'meal_title', :with => 'Gulasch'
	  fill_in 'meal_description', :with => 'doch nicht scharf und ohne Knödel'
	  click_on('meal_submit')
	  check_design ['doch nicht scharf und ohne Knödel', 'Gulasch']
    end
  end

  test "be able to create comment" do
    sign_in_as("Mr.Test7", "test7", "user7@gmail.com", "123456")
    click_link('cook')
    create_meal
	
    fill_in 'body', :with => 'Supa woas'
    click_button('comment_submit')
    #check_design ['Supa woas', 'Hans Testuser']
    sign_out

    sign_in_as("Mr.Test8", "test8", "user8@gmail.com", "123456")
    visit '/'

    visit_last_meal
    fill_in 'body', :with => 'MHM'
    click_on('comment_submit')
    sign_out
  end

  test "be able to follow other user" do
    sign_in_as("Mr.Test9", "test9", "user9@gmail.com", "123456")

    click_on('cook')
    
    create_meal
    sign_out

    sign_in_as("Mr.Test10", "test10", "user10@gmail.com", "123456")
    visit_last_meal
    click_link('Follow')
    check_design ["following..."]
    click_link('Unfollow')
    check_design ["Removed fellowship"]

  end

  test "be able to send message" do
    sign_in_as("Mr.Test11", "test11", "user11@gmail.com", "123456")
    click_on('cook')
    
    create_meal
    usr_id = User.last.id
    sign_out

    sign_in_as("Mr.Test12", "test12", "_user12@gmail.com", "654321")
    visit_last_meal
    click_link('Follow')
    visit '/users/'+usr_id.to_s
   
    click_link('send_message_button')

    fill_in 'Topic', :with => 'Seas Franzeus'
    fill_in 'Body', :with => 'wie geht es Dir denn so ??'
    click_on('submit')
    check_design ["Hans Testuser's Profil"]
    sign_out

    login_user 1
    click_link('personal Messages')
    check_design ["Seas Franzeus"]
  end

  test "be able to edit his/her profile" do
    sign_in_as("Mr.Test13", "test13", "user13@gmail.com", "123456")
    click_link("edit Profile")
    fill_in 'First Name:', :with => 'Hansilein'
    fill_in 'Last Name:', :with => 'Noname'
    select 'female', :from => 'Gender:'
    click_on('Update')

    click_link('Profile Information')
    fill_in 'Some Information about you which is displayed on your profile page:', :with => 'Hallo mein Name ist Hansilein'
    click_on('Update')

    click_link('Address')
    fill_in 'Country', :with => 'Salzburg'
    click_on('Update')

    click_link('Hansilein Noname')
    click_link('info')
    check_design ["Hallo mein Name ist Hansilein"]
  end
  
  # Franz Josef Brünner Integration-Test:
 
  test "user should be rejected when another user has got same first name" do
    
    @user = FactoryGirl.create(:user) if User.all.empty?
    
	Capybara.using_session("id") do
      visit root_path
      click_link('register')
      fill_in 'user_first_name', :with => @user.first_name + "1"
      fill_in 'user_last_name', :with => @user.last_name
      select 'male', :from => 'user_gender'
      fill_in 'user_email', :with => "testuser13@test.com"
      fill_in 'user_password', :with => 'geheim'
      fill_in 'user_password_confirmation', :with => 'geheim'
      click_on('user_submit')
	  
      page.has_content?('Invalid email or password')
    end
  end
  
  test "user should be rejected when another user has got same last name" do
    
    @user = FactoryGirl.create(:user) if User.all.empty?
    
	Capybara.using_session("id") do
      visit root_path
      click_link('register')
      fill_in 'user_first_name', :with => 'Mr.Test2'
      fill_in 'user_last_name', :with => @user.last_name + "2"
      select 'male', :from => 'user_gender'
      fill_in 'user_email', :with => "testuser14@test.com"
      fill_in 'user_password', :with => 'geheim'
      fill_in 'user_password_confirmation', :with => 'geheim'
      click_on('user_submit')
	  
      page.has_content?('Invalid email or password')
    end
  end
  
  test "current home location of user must be shown in new meal category" do
    
    sign_in_as("Mr.Test15", "test14", "user14@gmail.com", "123456")

    createCurrentUserLocation @user
    
	Capybara.using_session("id") do
	  visit root_path
	  click_link 'Login'
	  fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
      click_on('user_submit')
      
      click_on('cook')
      
      assert_equal @user.current_user_location.street, find_field('meal_street').value
      assert_equal @user.current_user_location.street_number, find_field('meal_street_number').value.to_i
      assert_equal @user.current_user_location.zip_code, find_field('meal_zip_code').value.to_i
      assert_equal @user.current_user_location.city, find_field('meal_city').value
      assert_equal @user.current_user_location.country, find_field('meal_country').value
      
    end
  end

end
