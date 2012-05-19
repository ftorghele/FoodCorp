class CreateCurrentUserLocations < ActiveRecord::Migration
  def self.up
    create_table :current_user_locations do |t|
      t.integer :user_id
      t.string :street
      t.integer :street_number
      t.integer :zip_code
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :current_user_locations
  end
end
