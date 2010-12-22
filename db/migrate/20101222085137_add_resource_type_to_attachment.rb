class AddResourceTypeToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :resource_type, :string
  end

  def self.down
    remove_column :attachments, :resource_type
  end
end
