class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.integer :login_count, :default => 0
      t.integer :login_time, :default => 0 

      t.timestamps
    end
  end
end
