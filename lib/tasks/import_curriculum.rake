# encoding: utf-8

def string_to_boolean(string)
  unless string.blank?
    return false if string.downcase != 'true'
  end

  true
end

def validate_params
  unless ENV.include?('file') && ENV.include?('chairs_from')
    raise "usage: rake import:curriculum file=<path to xml>
                            chairs_from=<chair slug>
                            with_practics=<true|false> (optional, default true)
                            study=<fulltime|parttime|postal> (optional, default fulltime)"
  end
end

namespace :import do
  desc 'Импорт учебного плана'
  task :curriculum => :environment do

    validate_params

    path = ENV['file']
    chairs_from = ENV['chairs_from']
    with_practics = string_to_boolean(ENV['with_practics'])
    study = ENV['study'] || 'fulltime'

    puts 'Импорт учебного плана'
    importer = Import::Importer.new(path, chairs_from, study, with_practics, true)
    importer.import

    puts 'Индексация'
    Rake::Task['sunspot:reindex'].execute
  end
end

