# encoding: utf-8

class Roles::Student < Role
  validates_presence_of :group, :birthday
  validates_uniqueness_of :group, :scope => [:human_id, :state]

  default_values :title => 'Студент', :slug => 'student'

end

