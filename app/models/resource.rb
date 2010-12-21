class Resource < ActiveRecord::Base
  include AASM
  
  belongs_to :curriculum
  #has_one :attachment
  
  aasm_column :state
  aasm_initial_state :unpublished
  
  aasm_state :unpublished
  aasm_state :published
  
  aasm_event :publish do
    transitions :to => :published, :from => [:unpublished]
  end
end

# == Schema Information
#
# Table name: resources
# Human name: Ресурс
#
#  id            :integer         not null, primary key
#  name          :string(255)     'Название'
#  state         :string(255)
#  year          :integer         'Год издания'
#  curriculum_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

