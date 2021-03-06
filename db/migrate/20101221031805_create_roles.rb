class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.references :human
      t.string :title
      t.string :slug
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
