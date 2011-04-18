class Meal < ActiveRecord::Base
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :user_id, :presence => true
  validates :time, :presence => true
  validates :deadline, :presence => true
  validates :lon, :presence => true
  validates :lat, :presence => true
  
  belongs_to :user, :dependent => :destroy
  
end
