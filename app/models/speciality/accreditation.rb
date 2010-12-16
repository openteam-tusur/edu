class Speciality::Accreditation < ActiveRecord::Base
  validates_presence_of :number, :issued_at

  belongs_to :speciality
end

