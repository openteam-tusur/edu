class AddCycleToPlanStudy < ActiveRecord::Migration
  def self.up
    add_column :plan_studies, :cycle, :string
  end

  def self.down
    remove_column :plan_studies, :cycle
  end
end

