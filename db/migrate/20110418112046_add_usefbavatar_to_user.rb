class AddUsefbavatarToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :use_fb_avatar, :boolean
  end

  def self.down
    remove_column :users, :use_fb_avatar
  end
end
