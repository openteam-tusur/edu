class CreatePlanStudies < ActiveRecord::Migration
  def self.up
    create_table :plan_studies do |t|
      t.references :chair
      t.references :curriculum
      t.references :discipline

      t.timestamps
    end
  end

  def self.down
    drop_table :plan_studies
  end
end

