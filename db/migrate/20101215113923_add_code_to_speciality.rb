class AddCodeToSpeciality < ActiveRecord::Migration
  def self.up
    add_column :specialities, :code, :string
  end

  def self.down
    remove_column :specialities, :code
  end
end
