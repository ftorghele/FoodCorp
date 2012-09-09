class AddActivateToUserLocation < ActiveRecord::Migration
  def self.up
   add_column :location, :activate, :boolean, :default => true
  end

  def self.down
   remove_column :location, :activate
  end
end
