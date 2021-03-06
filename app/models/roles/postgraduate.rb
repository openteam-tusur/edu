# encoding: utf-8

class Postgraduate < Role
  validates_presence_of :chair
  validates_uniqueness_of :chair_id, :scope => [:human_id, :state]

  default_values :title => 'Аспирант', :slug => 'employee'


  def to_s
    "#{title} каф. #{chair.try(:abbr)}"
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

