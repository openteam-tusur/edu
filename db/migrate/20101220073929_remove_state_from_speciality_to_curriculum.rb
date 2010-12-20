class RemoveStateFromSpecialityToCurriculum < ActiveRecord::Migration
  def self.up
    remove_column :specialities, :state
    add_column :plan_curriculums, :state, :string
  end

  def self.down
    add_column :specialities, :state, :string
    remove_column :plan_curriculums, :state
  end
end
