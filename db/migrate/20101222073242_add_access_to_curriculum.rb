class AddAccessToCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :access, :string
  end

  def self.down
    remove_column :plan_curriculums, :access
  end
end
