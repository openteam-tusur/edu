Settings.read Rails.root.join 'config', 'settings.yml'
#Settings.define 'secret_token',              :env_var => 'SECRET_TOKEN',       :required => true

Settings.define 'students.host',              :env_var => 'STUDENTS_HOST'

Settings.define 'hoptoad.api_key',            :env_var => 'HOPTOAD_API_KEY'
Settings.define 'hoptoad.host',               :env_var => 'HOPTOAD_HOST'

Settings.resolve!

#SETTINGS = YAML.load_file(Rails.root.join("config", "settings.yml"))[Rails.env]

#STUDENTS_HOST = SETTINGS['students']['host']

