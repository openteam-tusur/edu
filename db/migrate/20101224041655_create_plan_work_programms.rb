class CreatePlanWorkProgramms < ActiveRecord::Migration
  def self.up
    create_table :plan_work_programms do |t|
      t.references :education
      t.references :human
      t.string :access
      t.string :state
      t.text :resource_name
      t.integer :year

      t.timestamps
    end
  end

  def self.down
    drop_table :plan_work_programms
  end
end
