# encoding: utf-8


def load_cycles
  Cycle.create!(:code => 'Б1', :name => 'Гуманитарный, социальный и экономический цикл', :degree => 'bachelor')
  Cycle.create!(:code => 'Б2', :name => 'Математический и естственнонаучный цикл', :degree => 'bachelor')
  Cycle.create!(:code => 'Б3', :name => 'Профессиональный цикл', :degree => 'bachelor')
  Cycle.create!(:code => 'Б4', :name => 'Физическая культура', :degree => 'bachelor')
  Cycle.create!(:code => 'Б5', :name => 'Учебная и производственная практики', :degree => 'bachelor')
  Cycle.create!(:code => 'Б6', :name => 'Итоговая государственная аттестация', :degree => 'bachelor')
  Cycle.create!(:code => 'ФТД', :name => 'Факультативы', :degree => 'bachelor')

  Cycle.create!(:code => 'М1', :name => 'Общенаучный цикл', :degree => 'master')
  Cycle.create!(:code => 'М2', :name => 'Профессиональный цикл', :degree => 'master')
  Cycle.create!(:code => 'М3', :name => 'Практика и научно-исследовательская работы', :degree => 'master')
  Cycle.create!(:code => 'М4', :name => 'Итоговая аттестация', :degree => 'master')
end

def load_examinations
  YAML.load_file(Rails.root.join('config', 'dictionaries.yml')).each do |model, dictionary|
    klass = model.singularize.camelize.constantize
    dictionary.each do |slug, attributes|
      klass.find_or_initialize_by_slug(slug).update_attributes! attributes
    end
  end
end

def load_chairs
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
end

