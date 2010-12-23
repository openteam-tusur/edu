class AddChairAndPostToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :chair_id, :integer
    add_column :roles, :post, :string
  end

  def self.down
    remove_column :roles, :chair_id
    remove_column :roles, :post
  end
end

