Settings.read(Rails.root.join('config', 'settings.yml'))

Settings.defaults Settings.extract!(Rails.env)[Rails.env] || {}
Settings.extract!(:test, :development, :production)

Settings.define 'domain',                       :required => Rails.env.production?
Settings.define 'mailer.send_notifcations_to',  :required => true
Settings.define 'students.host',                :required => Rails.env.production?
Settings.define 'hoptoad.api_key',              :required => Rails.env.production?
Settings.define 'hoptoad.host',                 :required => Rails.env.production?

Settings.resolve!
