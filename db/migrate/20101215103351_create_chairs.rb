class CreateChairs < ActiveRecord::Migration
  def self.up
    create_table :chairs do |t|
      t.references :faculty
      t.string :name
      t.string :abbr
      t.string :slug

      t.timestamps
    end
  end

  def self.down
    drop_table :chairs
  end
end
