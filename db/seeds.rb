# encoding: utf-8

YAML.load_file(Rails.root.join('config', 'faculties.yml')).each do |slug, attributes|
  faculty = Faculty.find_or_initialize_by_slug(slug)
  chairs = attributes.delete('chairs')
  faculty.update_attributes! attributes
  next unless chairs
  chairs.each do | slug, attributes |
    chair = faculty.chairs.find_or_initialize_by_slug slug
    chair.update_attributes! attributes
  end
end

YAML.load_file(Rails.root.join('config', 'dictionaries.yml')).each do |model, dictionary|
  klass = model.singularize.camelize.constantize
  dictionary.each do |slug, attributes|
    klass.find_or_initialize_by_slug(slug).update_attributes! attributes
  end
end

User.destroy_all
Role.destroy_all

admin = User.create(:email => 'admin@demo.de',
                   :password => '123123',
                   :password_confirmation => '123123')

admin.human.update_attributes( :name => 'Иван',
                               :surname => 'Иванов',
                               :patronymic => 'Иванович' )

admin.human.roles << Roles::Admin.new(:title => 'Администратор', :slug => 'admin')

