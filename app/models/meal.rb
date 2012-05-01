class Meal < ActiveRecord::Base
  
  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "50x50>" }
  
  validates_attachment_content_type :avatar, :content_type => [ 'image/jpeg', 'image/png'],
						            :message => 'file must be of filetype .jpeg or .png'   
  
  acts_as_commentable

  attr_accessible :title, :description, :time, :deadline, :lon, :lat,
                  :country, :city, :zip_code, :street, :slots, :street_number, :avatar

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
