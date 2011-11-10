class CreateMonths < ActiveRecord::Migration
  def self.up
    create_table :months do |t|
      t.string :title
      t.integer :year_id

      t.timestamps
    end
  end

  def self.down
    drop_table :months
  end
end
