class AddChairToPlanEducation < ActiveRecord::Migration
  def self.up
    add_column :plan_educations, :chair_id, :integer
  end

  def self.down
    remove_column :plan_educations, :chair_id
  end
end
