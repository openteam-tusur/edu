require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'shoulda/integrations/rspec2'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|

    config.include AttributeNormalizer::RSpecMatcher, :type => :model

    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    config.before(:each) do
      require 'factory_girl_rails'
    end

    config.after(:each) do
      ActiveRecord::Base.descendants.each do | klass |
        klass.delete_all unless klass.abstract_class?
        klass.solr_remove_all_from_index if klass.respond_to? :solr_remove_all_from_index
      end
    end
  end
end

