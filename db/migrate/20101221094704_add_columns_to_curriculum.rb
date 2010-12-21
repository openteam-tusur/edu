class AddColumnsToCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :name, :string
    add_column :plan_curriculums, :year, :integer
  end

  def self.down
    remove_column :plan_curriculums, :name
    remove_column :plan_curriculums, :year
  end
end
