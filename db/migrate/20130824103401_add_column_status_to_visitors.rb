class AddColumnStatusToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :status, :integer, :default => 0
  end
end
