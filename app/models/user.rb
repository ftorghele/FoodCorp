class User < ActiveRecord::Base
  
  has_many :meals
  has_many :meal_arrangements

  # Followers
  has_many :fellowships
  has_many :followers, :through => :fellowships
  has_many :inverse_fellowships, :class_name => "Fellowship", :foreign_key => "follower_id"
  has_many :inverse_followers, :through => :inverse_fellowships, :source => :user

  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "50x50>" }
  
  acts_as_messageable
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender, :birthday, :fb_id, :avatar, :use_fb_avatar,
                  :country, :city, :zip_code, :street, :street_number, :phone_number, :info_field

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :gender, :presence => true

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user.fb_id = data["id"]
      user.birthday = data["birthday"]

      if data["hometown"] # Insert hometown if available on
        hometown = data["hometown"]["name"].to_s.split(", ")
        user.country = hometown[2] if user.country.blank?
        user.city = hometown[0] if user.city.blank?
      end
      
      user.confirm!
      user.save
      user
    else # Create an user with a stub password and some data from fb.
      user = User.new(:email => data["email"],
                      :password => Devise.friendly_token[0,20],
                      :first_name => data["first_name"],
                      :last_name => data["last_name"],
                      :gender => data["gender"],
                      :birthday => data["birthday"],
                      :fb_id => data["id"],
                      :use_fb_avatar => true
                     )

      if data["hometown"] # Insert hometown if available on
        hometown = data["hometown"]["name"].to_s.split(", ")
        user.country = hometown[2]
        user.city = hometown[0]
      end

      user.confirm!
      user.save!
      user
    end
  end

  def password_required?
    new_record?
  end

  def fb_user
    if fb_id
      true
    end
  end
end
