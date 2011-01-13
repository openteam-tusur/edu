class AddSinceToCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :since, :integer
  end

  def self.down
    remove_column :plan_curriculums, :since
  end
end
