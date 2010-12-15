source "http://rubygems.org"

gem "rails"
gem "racc"

group :production do
  gem "pg"
  gem "exception_notification", :git => "git://github.com/rails/exception_notification", :require => "exception_notifier"
end

group :development do
  gem "rails3-generators"
  gem "autotest", :require => nil
  gem "spork"
  # introspection
  gem "rails-erd"
  gem "annotate", :git => "git://github.com/lda/annotate_models"
end

group :test do
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "capybara", :git => "git://github.com/jnicklas/capybara"
  gem "rr"
  gem "faker"
  gem "launchy"
  gem "factory_girl_rails"
end

group :test, :development do
  gem "rspec-rails"
  gem "steak", :git => "git://github.com/cavalle/steak"
end

# GUI
gem "compass"
gem "fancy-buttons"
gem "simple-navigation"
gem "formtastic", "1.1.0"
gem "show_for", :git => "git://github.com/jenkek/show_for"
gem "will_paginate", ">= 3.0.pre2"

# restful
gem "inherited_resources", :git => "git://github.com/josevalim/inherited_resources"

# enumerations in models
gem "has_enum", "~> 0.3.0"
