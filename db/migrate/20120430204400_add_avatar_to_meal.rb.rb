class AddAvatarToMeal < ActiveRecord::Migration
  def self.up
    change_table :meals do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :meals, :avatar
  end
end
