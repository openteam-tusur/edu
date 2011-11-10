class AddMonthIdToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :month_id, :integer
  end

  def self.down
    remove_column :records, :month_id
  end
end
