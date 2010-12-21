class RemoveColumnFromAttachments < ActiveRecord::Migration
  def self.up
    remove_column :attachments, :curriculum_id, :integer
  end

  def self.down
    add_column :attachments, :curriculum_id, :integer
  end
end
