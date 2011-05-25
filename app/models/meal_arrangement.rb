class MealArrangement < ActiveRecord::Base
  
  attr_accessible :meal_id, :user_id, :acceptance
  
  validates :user_id, :presence => true
  validates :meal_id, :presence => true

  
  has_one :user
  has_one :meal

  belongs_to :user
  belongs_to :meal
  


end
