class AddColumnToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :curriculum_id, :integer
  end

  def self.down
    remove_column :attachments, :curriculum_id, :integer
  end
end
