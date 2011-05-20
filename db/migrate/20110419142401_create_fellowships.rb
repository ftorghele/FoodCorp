class CreateFellowships < ActiveRecord::Migration
  def self.up
    create_table :fellowships do |t|
      t.integer :user_id
      t.integer :follower_id

      t.timestamps
    end
  end

  add_index :fellowships, :user_id,                :unique => true

  def self.down
    drop_table :fellowships
  end
end
