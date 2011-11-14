class AddSubjectIdToRecord < ActiveRecord::Migration
  def self.up
    add_column :records, :subject_id, :integer
  end

  def self.down
    remove_column :records, :subject_id
  end
end
