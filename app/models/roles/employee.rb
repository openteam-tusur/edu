# encoding: utf-8

class Employee < Role
  #validates_presence_of :post, :chair, :unless => :other?
  validates_presence_of :post, :chair, :unless => :other?
  validates_uniqueness_of :chair_id, :scope => [:human_id, :state], :unless => :other?
  validates_uniqueness_of :other, :scope => [:human_id, :state], :unless => :chair_id?

  default_values :title => 'Сотрудник', :slug => 'employee'


  def to_s
    if chair.nil?
      "#{post.mb_chars.downcase} подр. #{other}"
    else
      "#{post.mb_chars.downcase} каф. #{chair.abbr}"
    end
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

