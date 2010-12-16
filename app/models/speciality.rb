class Speciality < ActiveRecord::Base
  belongs_to :chair
  has_many :disciplines

  validates_presence_of :name, :qualification, :code, :degree, :chair

  has_enum :degree, %w[specialist master bachelor]
end

