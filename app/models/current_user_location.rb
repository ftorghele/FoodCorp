class CurrentUserLocation < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  
  validates :street, :presence => true 
  validates :street_number, :presence => true
  validates :zip_code, :presence => true
  validates :city, :presence => true
end
