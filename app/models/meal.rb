class Meal < ActiveRecord::Base
  
  acts_as_commentable

  attr_accessible :title, :description, :time, :deadline, :lon, :lat,
                  :country, :city, :zip_code, :street, :slots, :street_number,
		          :vegetarien, :organic, :kosher, :asian, :gluten_free, 
		          :lactose_free, :diabetics, :hot, :veryhot, :halal, :eat_in, 
		          :take_away, :got_point, :times, :deadline_time

  validates :title, :presence => true
  validates :description, :presence => true
  validates :time, :presence => true
  validates :deadline, :presence => true
  /validates :lon, :presence => true
  validates :lat, :presence => true/
  validates :slots, :presence => true
  
  belongs_to :user
  has_many :meal_arrangements
  has_many :comments
  has_many :rating

  geocoded_by :address, :latitude  => :lat, :longitude => :lon
  reverse_geocoded_by :lat, :lon
	
  def check_time
    if time.present? && times.present?
      time + (times.strftime('%H').to_i).hours - 2.hours + (times.strftime('%M').to_i).minutes
    else
      "unbekannt"
    end
  end
  

  def check_time
    if time.present? && times.present?
      time + (times.strftime('%H').to_i).hours - 3.hours + (times.strftime('%M').to_i).minutes
    end
  end
  
  def short_time
    if times.present?
      times.strftime('%H:%M')
    end
  end
  
  def short_deadline
    if deadline_time.present?
      deadline_time.strftime('%H:%M')
    end
  end
 / def check_deadline
    created_at.strftime('%d.%m').eql? Time.now.strftime('%d.%m')
  end/
end
