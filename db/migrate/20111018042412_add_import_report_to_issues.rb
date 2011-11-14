class AddImportReportToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :import_report, :text
  end

  def self.down
    remove_column :issues, :import_report
  end
end

