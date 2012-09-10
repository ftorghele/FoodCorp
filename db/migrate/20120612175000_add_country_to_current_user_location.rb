class AddCountryToCurrentUserLocation < ActiveRecord::Migration
  def self.up
    add_column :current_user_locations, :country, :text
  end

  def self.down
   remove_column :current_user_locations, :country
  end
end
