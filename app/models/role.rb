class Role < ActiveRecord::Base
  include AASM

  belongs_to :human

  aasm_column :state

  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :accepted
  aasm_state :rejected
  aasm_state :expired

  aasm_event :accept do
    transitions :from => :pending, :to => :accepted
  end

  aasm_event :reject do
    transitions :from => :pending, :to => :rejected
  end

  aasm_event :expire do
    transitions :from => :accepted, :to => :expired
  end
end

