class User < ActiveRecord::Base
  
  has_many :meal

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :gender, :birthday, :fb_id, :avatar,
                  :country, :city, :zip_code, :street, :street_number, :phone_number

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create an user with a stub password and some data from fb.
      user = User.new(:email => data["email"],
                      :password => Devise.friendly_token[0,20],
                      :first_name => data["first_name"],
                      :last_name => data["last_name"],
                      :gender => data["gender"],
                      :birthday => data["birthday"],
                      :fb_id => data["id"]
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
end
