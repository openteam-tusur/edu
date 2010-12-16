Factory.define :speciality_accreditation,
                :default_strategy => :attributes_for,
                :class => 'Speciality::Accreditation' do |accreditation|
  accreditation.association :speciality
  accreditation.number '123123'
  accreditation.issued_at '2010.10.10'
end

