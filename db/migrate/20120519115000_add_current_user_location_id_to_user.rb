class AddCurrentUserLocationIdToUser < ActiveRecord::Migration
  def self.up
   add_column :users, :current_user_location_id, :integer, :default => 0
  end

  def self.down
   remove_column :users, :current_user_location_id
  end
end
