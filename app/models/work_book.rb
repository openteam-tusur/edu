# encoding: utf-8

class WorkBook < Resource
  set_table_name :work_books
  belongs_to  :chair

  has_many    :resource_disciplines, :as => :resource
  has_many    :authors, :as => :resource, :inverse_of => :resource
  accepts_nested_attributes_for :authors, :allow_destroy => true

  validates_presence_of :chair, :title, :attachment, :year, :access
end

