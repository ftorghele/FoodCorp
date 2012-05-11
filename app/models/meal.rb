class Meal < ActiveRecord::Base
  
  acts_as_commentable

  attr_accessible :title, :description, :time, :deadline, :lon, :lat,
                  :country, :city, :zip_code, :street, :slots, :street_number,
		  :vegetarian, :organic, :kosher, :asian, :gluten_free, 
		  :lactose_free, :diabetics

  validates :title, :presence => true
  validates :description, :presence => true
  validates :time, :presence => true
  validates :deadline, :presence => true
  validates :lon, :presence => true
  validates :lat, :presence => true
  validates :slots, :presence => true
  
  belongs_to :user
  has_many :meal_arrangements
  has_many :comments

  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon

end
