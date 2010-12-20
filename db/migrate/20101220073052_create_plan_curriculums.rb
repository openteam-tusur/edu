class CreatePlanCurriculums < ActiveRecord::Migration
  def self.up
    create_table :plan_curriculums do |t|
      t.string :form
      t.references :speciality

      t.timestamps
    end
  end

  def self.down
    drop_table :plan_curriculums
  end
end
