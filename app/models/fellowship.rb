class Fellowship < ActiveRecord::Base

  belongs_to :user
  belongs_to :follower, :class_name => "User"

  attr_accessible :user_id, :follower_id

  validates :user_id, :presence => true
  validates :follower_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :follower_id
end
