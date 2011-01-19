class RemoveResourceNameFromCurriculum < ActiveRecord::Migration
  def self.up
    remove_column :plan_curriculums, :resource_name
  end

  def self.down
    add_column :plan_curriculums, :resource_name, :string
  end
end
