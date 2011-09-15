class RemoveColumnToIssues < ActiveRecord::Migration
  def self.up
    remove_column :issues, :year
    remove_column :issues, :month
  end

  def self.down
    add_column :issues, :year, :string
    add_column :issues, :month, :string
  end
end

