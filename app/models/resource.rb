class Resource < ActiveRecord::Base
  include AASM
  
  belongs_to :curriculum
  has_one :attachment
  
  aasm_column :state
  aasm_initial_state :unpublished
  
  aasm_state :unpublished
  aasm_state :published
  
  aasm_event :publish do
    transitions :to => :published, :from => [:unpublished]
  end
end