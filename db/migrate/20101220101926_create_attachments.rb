class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string   :data_uid
      t.integer  :resource_id
      t.string   :data_file_name
      t.integer  :data_file_size
      t.string   :data_content_type
      t.datetime :data_updated_at
      t.string   :data_hash
    end
  end
  
  def self.down
    drop_table :attachments
  end
end

