class Role < ActiveRecord::Base
end
class RemovePrefixRolesFromRoleType < ActiveRecord::Migration
  def self.up
    rename_column :roles, :type, :typo
    Role.all.each do |role|
      role.update_attributes! typo: role.typo.gsub('Roles::','')
    end
    rename_column :roles, :typo, :type
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
