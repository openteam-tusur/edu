class RenameCollomsToMainSubjects < ActiveRecord::Migration
  def self.up
    add_column :main_subjects, :code, :string
    remove_column :main_subjects, :key
  end

  def self.down
    add_column :main_subjects, :key, :string
    remove_column :main_subjects, :code
  end
end

