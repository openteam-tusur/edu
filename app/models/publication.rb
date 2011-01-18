# encoding: utf-8

class Publication < Resource
  set_table_name :publications

  belongs_to  :chair

  has_many :resource_disciplines, :as => :resource
  has_many :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  validates_presence_of :chair, :title, :attachment, :year, :access, :volume

  has_enum :kind, %w(tutorial lab_work course_work attestation practice seminar test demo work_programm)

  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')
end

