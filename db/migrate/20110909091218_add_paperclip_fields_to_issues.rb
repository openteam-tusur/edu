class AddPaperclipFieldsToIssues < ActiveRecord::Migration
  def self.up
    add_column :issues, :data_file_name, :string
    add_column :issues, :data_file_size, :integer
    add_column :issues, :data_content_type, :string
    add_column :issues, :data_updated_at, :datetime
    add_column :issues, :data_hash, :string
  end

  def self.down
    remove_column :issues, :data_hash
    remove_column :issues, :data_updated_at
    remove_column :issues, :data_content_type
    remove_column :issues, :data_file_size
    remove_column :issues, :data_file_name
  end
end
