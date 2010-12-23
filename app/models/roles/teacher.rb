# encoding: utf-8

class Roles::Teacher < Role
  validates_presence_of :chair, :post
  validates_uniqueness_of :chair_id, :scope => :human_id

  default_values :title => 'Преподаватель', :slug => 'teacher'
end


# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  human_id   :integer
#  title      :string(255)
#  slug       :string(255)     'Слаг'
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)     'Статус'
#  group      :string(255)
#  birthday   :date
#  chair_id   :integer
#  post       :string(255)
#
