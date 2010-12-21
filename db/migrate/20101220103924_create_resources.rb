class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string  :name
      t.string  :state
      t.integer :year
      t.integer :curriculum_id
      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
