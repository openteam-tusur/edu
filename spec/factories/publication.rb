Factory.define :publication, :default_strategy => :attributes_for do |publication|
  publication.association   :chair
  publication.year          '2010'
  publication.title         'ololo'
  publication.volume        200
  publication.access        'free'
  publication.attachment    Attachment.new
end
