# encoding: utf-8

class Roles::Graduate < Role
  validates_presence_of :group, :birthday
  validates_uniqueness_of :group, :scope => [:human_id, :state]

  default_values :title => 'Магистрант', :slug => 'graduate', :post => 'Магистрант'

  def to_s
    "магистрант гр. #{group}"
  end
end


# == Schema Information
#
# Table name: roles
# Human name: Роль магистранта
#
#  id         :integer         not null, primary key
#  human_id   :integer
#  title      :string(255)
#  slug       :string(255)     'Слаг'
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)     'Статус'
#  group      :string(255)     'Группа'
#  birthday   :date            'Дата рождения'
#  chair_id   :integer
#  post       :string(255)     'Должность'
#

