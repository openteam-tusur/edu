Factory.define :speciality_accreditation,
                :default_strategy => :attributes_for,
                :class => 'Plan::Accreditation' do |accreditation|
  accreditation.association :speciality
  accreditation.number '123123'
  accreditation.issued_on '2010.10.10'
end

