class Speciality < ActiveRecord::Base
  belongs_to :chair
  has_many :disciplines

  has_enum :degree, %w[specialist master bachelor]
end

