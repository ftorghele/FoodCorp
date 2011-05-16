class Comment < ActiveRecord::Base

	belongs_to :meal
	belongs_to :user
	has_many :reports, :dependent => :destroy

	attr_accessible :user_id, :meal_id, :body, :visible

	validates :user_id, :presence => true
	validates :meal_id, :presence => true
	validates :body, :presence => true


end
