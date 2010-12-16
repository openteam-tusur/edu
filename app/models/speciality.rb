# encoding: utf-8

class Speciality < ActiveRecord::Base
  validates_presence_of :name, :qualification, :code, :degree, :chair

  belongs_to :chair

  has_many :disciplines

  has_one :licence
  accepts_nested_attributes_for :licence

  has_enum :degree, %w[specialist master bachelor]
end

