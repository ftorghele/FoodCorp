require 'test_helper'

class MealTest < ActiveSupport::TestCase
  
  should validate_presence_of(:title)
  should validate_presence_of(:description)
  should validate_presence_of(:time)
  should validate_presence_of(:deadline)
  should validate_presence_of(:lat)
  should validate_presence_of(:lon)
  should validate_presence_of(:slots)
  
  should "provide information of itself" do
    meal = Meal.new(:title => "title", 
                    :user_id => 1, 
                    :description => "Faker::Lorem",
                    :deadline => Time.now,
                    :avatar => "",
                    :time => Time.now,
                    :lat => 47.7992391,
                    :lon => 13.0440699,
                    :slots => 3
                    )
    meal.save
    
    assert meal.valid?, meal.errors.to_s
  end
end
