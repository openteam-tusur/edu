
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

Paperclip.interpolates :issue_id do |issue, style|
  issue.instance.id
end

Paperclip.interpolates :issue_year do |issue, style|
  issue.instance.year
end

Paperclip.interpolates :issue_month do |issue, style|
  issue.instance.month
end

Paperclip.interpolates :issue_theme do |issue, style|
  issue.instance.theme
end

Paperclip.interpolates :issue_group do |issue, style|
  issue.instance.theme_group
end

