class AddPlanCycleToPlanStudy < ActiveRecord::Migration
  def self.up
    add_column :plan_studies, :cycle_id, :integer
  end

  def self.down
    remove_column :plan_studies, :cycle_id
  end
end
