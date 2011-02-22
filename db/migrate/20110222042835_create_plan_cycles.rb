class CreatePlanCycles < ActiveRecord::Migration
  def self.up
    create_table :plan_cycles do |t|
      t.string :code
      t.string :name
      t.string :degree
      t.timestamps
    end
  end

  def self.down
    drop_table :plan_cycles
  end
end
