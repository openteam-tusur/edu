class Speciality < ActiveRecord::Base
  has_enum :degree, %w[specialist master bachelor]
end

