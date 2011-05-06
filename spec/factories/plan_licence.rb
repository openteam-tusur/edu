Factory.define :speciality_licence,
                :default_strategy => :attributes_for,
                :class => 'Licence' do |licence|
  licence.association :speciality
  licence.number '123123'
  licence.issued_on '2010.10.10'
end

