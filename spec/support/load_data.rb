# encoding: utf-8

def load_cycles
  Plan::Cycle.create!(:code => 'Б1', :name => 'Гуманитарный, социальный и экономический цикл', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'Б2', :name => 'Математический и естственнонаучный цикл', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'Б3', :name => 'Профессиональный цикл', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'Б4', :name => 'Физическая культура', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'Б5', :name => 'Учебная и производственная практики', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'Б6', :name => 'Итоговая государственная аттестация', :degree => 'bachelor')
  Plan::Cycle.create!(:code => 'ФТД', :name => 'Факультативы', :degree => 'bachelor')
end

def load_examinations
  YAML.load_file(Rails.root.join('config', 'dictionaries.yml')).each do |model, dictionary|
    klass = model.singularize.camelize.constantize
    dictionary.each do |slug, attributes|
      klass.find_or_initialize_by_slug(slug).update_attributes! attributes
    end
  end
end

