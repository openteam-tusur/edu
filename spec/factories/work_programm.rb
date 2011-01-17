Factory.define :work_programm, :default_strategy => :attributes_for do |work_programm|
  work_programm.association   :chair
  work_programm.year          '2010'
  work_programm.title         'ololo'
  work_programm.volume        200
  work_programm.resource_name 'ololo for trololo'
  work_programm.access        'free'
  work_programm.attachment    Attachment.new
end
