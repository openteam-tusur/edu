class AddFieldToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :extended_kind, :string
  end

  def self.down
    remove_column :publications, :extended_kind
  end
end

