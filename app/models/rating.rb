class Rating < ActiveRecord::Base
  
  attr_accessible :meal_id, :user_id, :rating

  validates :user_id, :presence => true
  validates :meal_id, :presence => true

  has_one :user
  has_one :meal

  belongs_to :user
  belongs_to :meal
  
  accepts_nested_attributes_for :meal

end
