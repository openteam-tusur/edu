class AddIssueIdToRecords < ActiveRecord::Migration
  def self.up
    add_column :records, :issue_id, :integer
  end

  def self.down
    remove_column :records, :issue_id
  end
end
