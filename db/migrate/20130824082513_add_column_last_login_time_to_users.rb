class AddColumnLastLoginTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login_time, :timestamp
  end
end
