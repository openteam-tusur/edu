class AddCommentToPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :comment, :text
  end

  def self.down
    remove_column :publications, :comment
  end
end
