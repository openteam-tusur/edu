class AddTitleToWorkProgramm < ActiveRecord::Migration
  def self.up
    add_column :work_programms, :title, :text
  end

  def self.down
    remove_column :work_programms, :title
  end
end
