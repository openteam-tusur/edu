
Paperclip.interpolates :chair_slug do |attachment, style|
  attachment.instance.resource.chair.slug
end

Paperclip.interpolates :year do |attachment, style|
  Date.today.year
end

Paperclip.interpolates :resource_type do |attachment, style|
  attachment.instance.resource_type.underscore
end


Paperclip.interpolates :resource_id do |attachment, style|
  attachment.instance.resource_id
end

Paperclip.interpolates :resource_name do |attachment, style|
  Russian.translit(attachment.instance.resource.title.truncate(30, :omission => '')).downcase.parameterize
end
