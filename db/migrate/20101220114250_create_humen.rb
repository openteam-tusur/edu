class CreateHumen < ActiveRecord::Migration
  def self.up
    create_table :humen do |t|
      t.references :user
      t.string :surname
      t.string :name
      t.string :patronymic

      t.timestamps
    end
  end

  def self.down
    drop_table :humen
  end
end
