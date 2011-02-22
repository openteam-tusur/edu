class RemoveCycleFromPlanStudy < ActiveRecord::Migration
  def self.up
    remove_column :plan_studies, :cycle
  end

  def self.down
    add_column :plan_studies, :cycle, :string
  end
end
