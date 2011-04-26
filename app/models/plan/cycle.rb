class Plan::Cycle < ActiveRecord::Base
  has_enum :degree, :scopes => true

  scope :with_degree, ->(degree) { where(:degree => degree) }
end

# == Schema Information
#
# Table name: plan_cycles
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  name       :string(255)     'Название'
#  degree     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

