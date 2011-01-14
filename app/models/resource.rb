class Resource < ActiveRecord::Base
  self.abstract_class = true

  include AASM

  has_one :attachment, :as => :resource
  accepts_nested_attributes_for :attachment, :reject_if => :all_blank

  has_many :resource_educations

  has_enum :access, %w[free restricted]

  aasm_column :state
  aasm_initial_state :unpublished

  aasm_state :unpublished
  aasm_state :published

  aasm_event :publish do
    transitions :to => :published, :from => [:unpublished]
  end

  aasm_event :unpublish do
    transitions  :to => :unpublished, :from => [:published]
  end

  searchable do
    text :title
    text :year
    string :authors, :multiple => true do
      authors.map(&:human).map(&:full_name)
    end if self.respond_to? :authors
  end

  private
    def need_all_resource_fields?
      resource_fields = %w[resource_name year access attachment]
      empty_fields = []
      resource_fields.each do |field|
        empty_fields << field if self.send(field).blank?
      end
      ! empty_fields.eql?(resource_fields)
    end
end

