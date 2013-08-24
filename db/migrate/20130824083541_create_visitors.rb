class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.integer :visitor_time, :default => 0
      t.timestamp :last_visitor

      t.timestamps
    end
  end
end
