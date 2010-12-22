class RenameNameToResourceNameInCurriculum < ActiveRecord::Migration
  def self.up
    rename_column :plan_curriculums, :name, :resource_name
  end

  def self.down
    rename_column :plan_curriculums, :resource_name, :name
  end
end
