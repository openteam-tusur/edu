class CreateEducationResources < ActiveRecord::Migration
  def self.up
    create_table :resource_educations do |t|
      t.integer :resource_id
      t.string :resource_type
      t.integer :education_id

      t.timestamps
    end
    remove_column :plan_educations, :work_programm_id
  end

  def self.down
    drop_table :resource_educations
    add_column :plan_educations, :work_programm_id, :integer
  end
end
