class RenameIssuedAtToIssuedOn < ActiveRecord::Migration
  def self.up
    rename_column :plan_licences, :issued_at, :issued_on
    rename_column :plan_accreditations, :issued_at, :issued_on
  end

  def self.down
    rename_column :plan_licences, :issued_on, :issued_at
    rename_column :plan_accreditations, :issued_on, :issued_at
  end
end
