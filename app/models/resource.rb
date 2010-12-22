class Resource < ActiveRecord::Base
  self.abstract_class = true

  include AASM

  has_one :attachment, :as => :resource
  accepts_nested_attributes_for :attachment, :reject_if => :all_blank
  has_enum :access, %w[free restricted]

  validates_presence_of :access, :resource_name, :if => :attachment

  aasm_column :state
  aasm_initial_state :unpublished

  aasm_state :unpublished
  aasm_state :published

  aasm_event :publish do
    transitions :to => :published, :from => [:unpublished]
  end

  aasm_event :unpublish do
    transitions  :to => :unpublished, :from => :published
  end
end
