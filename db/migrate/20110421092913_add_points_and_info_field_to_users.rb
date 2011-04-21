class AddPointsAndInfoFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :points, :integer, :default => 0
    add_column :users, :info_field, :text
  end

  def self.down
    remove_column :users, :points
    remove_column :users, :info_field
  end
end
