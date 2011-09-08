Settings.read(Rails.root.join('config', 'settings.yml'))

Settings.defaults Settings.extract!(Rails.env)[Rails.env] || {}
Settings.extract!(:test, :development, :production)

Settings.define 'domain',                         :required => true
Settings.define 'mailer.send_notifications_from', :required => true
Settings.define 'mailer.send_notifications_to',   :required => true
Settings.define 'students.host',                  :required => Rails.env.production?
Settings.define 'hoptoad.api_key',                :required => Rails.env.production?
Settings.define 'hoptoad.host',                   :required => Rails.env.production?

Settings.resolve!
