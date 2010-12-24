class CreateWorkProgramms < ActiveRecord::Migration
  def self.up
    create_table :work_programms do |t|
      t.references :chair
      t.integer :year
      t.string :state
      t.string :access
      t.text :resource_name

      t.timestamps
    end
  end

  def self.down
    drop_table :work_programms
  end
end
