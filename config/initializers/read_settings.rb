SETTINGS = YAML.load_file(Rails.root.join("config", "settings.yml"))[Rails.env]

STUDENTS_HOST = SETTINGS['students']['host']

