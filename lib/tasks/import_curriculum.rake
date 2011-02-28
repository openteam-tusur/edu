# encoding: utf-8

namespace :import do
  desc 'Import curriculum'
  task :curriculum => :environment do
    path = ENV['FILE']
    chairs_from = ENV['CHAIRS_FROM']

    importer = Import::Importer.new(path, chairs_from)
    importer.import
  end
end

