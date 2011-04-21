class MealArrangement < ActiveRecord::Base
  
  attr_accessible :meal_id, :user_id
  
  validates :user_id, :presence => true
  validates :meal_id, :presence => true

  
  has_many :user
  has_one :meal

  belongs_to :user
  
end
