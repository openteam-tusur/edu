class AddChairToPlanCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :chair_id, :integer
  end

  def self.down
    remove_column :plan_curriculums, :chair_id
  end
end

