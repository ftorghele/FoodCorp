require 'test_helper'

class MealsControllerTest < ActionController::TestCase
  
  setup do 
    @meals_params = { :title => "title", :user_id => 1, :description => "Faker::Lorem", :deadline => Time.now, :avatar => "", :time => Time.now, :lat => 47.7992391, :lon => 13.0440699, :slots => 3 }
  end
  
  test "the truth" do
    assert true
  end
  
  # Test-Code von Franz Josef Brünner 
  test "is meal updated correctly" do
    @meal = Meal.create(@meals_params)
    @meal.update_attributes({ :title => "title2", :user_id => 2, :description => "Faker::Lorem", :deadline => Time.now, :avatar => "", :time => Time.now, :lat => 48.7992391, :lon => 15.0440699, :slots => 6 })
    assert_redirected_to meal_path(@meal.id)
  end
  # Test-Code von Franz Josef Brünner
end
