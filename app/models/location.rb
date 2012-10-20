class Location < ActiveRecord::Base
  
  attr_accessible :street,:street_number, :zip_code, :city, :country, :user
  
  belongs_to :user, :dependent => :destroy
  
  validates :street, :presence => true 
  validates :street_number, :presence => true
  validates :zip_code, :presence => true
  validates :city, :presence => true
  validates :country, :presence => true
  
end
