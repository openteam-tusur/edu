# encoding: utf-8

class Roles::Admin < Role
  default_values :title => 'Администратор', :slug => 'admin', :post => 'Администратор'

  def to_s
    'администратор системы'
  end
end



# == Schema Information
#
# Table name: roles
#
#  id            :integer         not null, primary key
#  human_id      :integer
#  title         :string(255)
#  slug          :string(255)
#  type          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)
#  group         :string(255)
#  birthday      :date
#  chair_id      :integer
#  post          :string(255)
#  contingent_id :integer
#

