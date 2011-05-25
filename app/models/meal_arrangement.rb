class MealArrangement < ActiveRecord::Base
  
  attr_accessible :meal_id, :user_id, :acceptance
  
  validates :user_id, :presence => true
  validates :meal_id, :presence => true

  
  has_one :user
  has_one :meal

  belongs_to :user
  belongs_to :meal
  
  def self.get_meal_arrangement arg
    where(:id => arg)
  end

  def self.get_meal_arrangement_from_user_and_meal args
    #where(:meal_id => args[0] AND :user_id => args[1]).first
  end

end
