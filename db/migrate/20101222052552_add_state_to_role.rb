class AddStateToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :state, :string
  end

  def self.down
    remove_column :roles, :state
  end
end
