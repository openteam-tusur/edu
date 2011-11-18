class RenameDataHashToDataFingerprintInIssueAndAttachment < ActiveRecord::Migration
  def self.up
    rename_column :issues, :data_hash, :data_fingerprint
    rename_column :attachments, :data_hash, :data_fingerprint
  end

  def self.down
    rename_column :issues, :data_fingerprint, :data_hash
    rename_column :attachments, :data_fingerprint, :data_hash
  end
end
