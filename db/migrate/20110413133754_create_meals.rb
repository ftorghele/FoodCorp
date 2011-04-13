class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.timestamp :time
      t.timestamp :deadline
      t.float :lat
      t.float :lon
      t.string :country
      t.string :city
      t.string :zip_code
      t.string :street
      t.string :street_number

      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
