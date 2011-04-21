class Meal < ActiveRecord::Base

  attr_accessible :title, :description, :time, :deadline, :lon, :lat,
                  :country, :city, :zip_code, :street, :street_number
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :time, :presence => true
  validates :deadline, :presence => true
  validates :lon, :presence => true
  validates :lat, :presence => true
  validates :slots, :presence => true
  
  belongs_to :user
  has_many :meal_arrangements
  
end
