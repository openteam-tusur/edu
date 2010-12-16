class DosciplineToSpecialityNamespace < ActiveRecord::Migration
  def self.up
    rename_table :disciplines, :speciality_disciplines
  end

  def self.down
    rename_table :speciality_disciplines, :disciplines
  end
end
