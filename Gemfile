source 'http://rubygems.org'

gem 'rails'
gem 'racc'

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
end

group :test do
  gem "shoulda"
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara'
  gem 'rr'
  gem 'faker'
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
gem 'show_for'
gem 'will_paginate', '>= 3.0.pre2'
gem 'dynamic_form'
gem 'russian'

# restful
gem 'inherited_resources', :git => 'git://github.com/lda/inherited_resources'
gem 'inherited_resources_views'

# enumerations in models
gem 'has_enum', '~> 0.3.0'

gem 'aasm'

