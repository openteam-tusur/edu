source 'http://rubygems.org'

gem 'rails', :require => false
gem 'racc', :require => false

group :production do
  gem 'pg'
  gem 'exception_notification',
      :git => 'git://github.com/rails/exception_notification',
      :require => 'exception_notifier'
end

group :development do
  gem 'rails3-generators'
  gem 'autotest', :require => nil
  gem 'spork'
  # introspection
  gem 'rails-erd'
  gem 'annotate', :git => 'git://github.com/lda/annotate_models'
  gem 'hirb'
end

group :test do
  gem "shoulda"
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara'
  gem 'rr'
  gem 'launchy'
  gem 'factory_girl_rails'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'steak', :git => 'git://github.com/cavalle/steak'
end

# GUI
gem 'jquery-rails'
gem 'compass'
gem 'fancy-buttons'
gem 'simple-navigation'
gem 'formtastic'
gem 'validation_reflection'
gem 'show_for', :git => "git://github.com/plataformatec/show_for"
gem 'will_paginate', '>= 3.0.pre2'
gem 'dynamic_form'
gem 'russian'

# restful
gem 'inherited_resources', :git => 'git://github.com/openteam/inherited_resources'
gem 'inherited_resources_views'

# smart deletions
gem "protected_parent"

# enumerations in models
gem 'has_enum', :git => 'git://github.com/openteam/has_enum'

# full text search
gem "geohash", "1.0.1", :git => "git://github.com/floze/geohash", :require => false
gem "sunspot"
gem "sunspot_rails"

gem 'aasm', :git => "git://github.com/etehtsea/aasm"
gem 'devise'
gem 'cancan'

# file management
gem 'paperclip'

gem "default_value_for"

