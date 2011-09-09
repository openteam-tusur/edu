# encoding: utf-8

class Issue < ActiveRecord::Base

  has_many :records

end


# == Schema Information
#
# Table name: issues
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

