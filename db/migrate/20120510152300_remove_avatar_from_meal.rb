class RemoveAvatarFromMeal < ActiveRecord::Migration
  def self.up
    drop_attached_file :meals, :avatar
  end

  def self.down
    drop_attached_file :meals, :avatar
  end
end
