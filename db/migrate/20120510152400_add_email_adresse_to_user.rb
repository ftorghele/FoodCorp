class AddEmailAdresseToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email_adresse, :text
  end

  def self.down
   remove_column :users, :email_adresse
  end
end
