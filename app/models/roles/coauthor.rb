# encoding: utf-8

class Coauthor < Role
  default_values :title => 'Соавтор', :slug => 'coauthor', :post => 'соавтор'

  def to_s
    title
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

