class Speciality < ActiveRecord::Base
  belongs_to :chair

  has_enum :degree, %w[specialist master bachelor]
end

