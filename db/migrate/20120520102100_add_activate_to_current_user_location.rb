class AddActivateToCurrentUserLocation < ActiveRecord::Migration
  def self.up
   add_column :current_user_locations, :activate, :boolean, :default => true
  end

  def self.down
   remove_column :current_user_locations, :activate
  end
end
