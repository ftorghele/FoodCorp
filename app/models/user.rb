class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :sex, :city, :state, :country


  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      address = data["hometown"]["name"].split(", ")
      User.create!( :email => data["email"],
                    :password => Devise.friendly_token[0,20],
                    :first_name => data["first_name"],
                    :last_name => data["last_name"],
                    :sex => data["gender"],
                    :city => address[0],
                    :state => address[1],
                    :country => address[2]
                  )
    end
  end
end
