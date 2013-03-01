class AddPermissionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :permissions, :text
  end
end
