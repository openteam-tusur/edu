class AddProfileToPlanCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :profile, :string
  end

  def self.down
    remove_column :plan_curriculums, :profile
  end
end
