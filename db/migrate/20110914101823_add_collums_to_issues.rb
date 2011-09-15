class AddCollumsToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :year, :string
    add_column :issues, :month, :string
    add_column :issues, :disk_id, :integer
    remove_column :issues, :title
  end

  def self.down
    remove_column :issues, :year
    remove_column :issues, :month
    remove_column :issues, :disk_id
    add_column :issues, :title, :string
  end
end

