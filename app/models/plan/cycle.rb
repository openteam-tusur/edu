# encoding: utf-8

class Cycle < ActiveRecord::Base
  set_table_name :cycles

  has_enum :degree, %w[specialist master bachelor], :scopes => true

  scope :with_degree, ->(degree) { where(:degree => degree) }
end


# == Schema Information
#
# Table name: cycles
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  name       :string(255)
#  degree     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

