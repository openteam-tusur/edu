# encoding: utf-8

class Disk < ActiveRecord::Base

  has_many :issues, :dependent => :destroy

  validates_presence_of :released_on

  default_scope order("released_on desc")

  def year
    released_on.year
  end

  def month
    released_on.month
  end

  def title
    "Обновление №#{month} за #{year} год"
  end

end







# == Schema Information
#
# Table name: disks
#
#  id          :integer         not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  released_on :date
#

