require 'test_helper'

class MealTest < ActiveSupport::TestCase
  
  test "provide information of itself" do
    meal = Meal.new(:title => "title", 
                    :user_id => 1, 
                    :description => "Faker::Lorem",
                    :deadline => Time.now,
                    :time => Time.now,
                    :lat => 47.7992391,
                    :lon => 13.0440699,
                    :slots => 3
                    )
    meal.save
    
    assert meal.valid?, meal.errors.to_s
  end
end
