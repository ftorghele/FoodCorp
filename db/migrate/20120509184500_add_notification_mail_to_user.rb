class AddNotificationMailToUser < ActiveRecord::Migration
  def self.up
   add_column :users, :mail_notification, :boolean, :default => 0
  end

  def self.down
   remove_column :users, :mail_notification
  end
end
