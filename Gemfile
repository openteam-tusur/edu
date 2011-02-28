#source 'http://rubygems.org'
source 'http://gems.openteam.ru'

gem 'rails', :require => false
gem 'racc', :require => false

group :production do
  gem 'pg'
  gem "exception_notification_rails3", :require => "exception_notifier"
end

group :development do
  gem 'rails3-generators'
  # introspection
  gem 'rails-erd'
  #gem 'annotate', :git => 'git://github.com/lda/annotate_models'
  gem 'hirb'
end

group :test do
  gem 'database_cleaner'
  gem "shoulda"
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capybara'
  gem 'rr'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'spork'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'steak'
end

# GUI
gem 'jquery-rails'
gem 'compass'
gem 'fancy-buttons'
gem 'simple-navigation'
gem 'formtastic'
gem 'formtastic_cocoon', :git => 'git://github.com/openteam/formtastic-cocoon'
gem 'validation_reflection'
gem 'show_for'
gem 'will_paginate', '>= 3.0.pre2'
gem 'dynamic_form'
gem 'russian'
gem 'gilenson'
gem 'gravtastic'

# restful
gem 'inherited_resources', :git => 'git://github.com/openteam/inherited_resources'
gem 'inherited_resources_views'

# full text search
gem "sunspot"
gem "sunspot_rails"

gem 'aasm', :git => 'git://github.com/etehtsea/aasm'
gem 'devise'
gem 'cancan'
gem 'has_enum'
gem "protected_parent"

# file management
gem 'paperclip'
gem "mime-types", :require => "mime/types"
gem "ruby-filemagic", :require => "filemagic"

gem "default_value_for"

gem 'mime-types', :require => 'mime/types'
gem 'nokogiri'

