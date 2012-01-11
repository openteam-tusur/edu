# encoding: utf-8

namespace :replace do
  desc 'Замена пути хранения вложений'
  task :attachments => :environment do

    puts "Перенос вложений УМО"

    Publication.where('year < 2011').each do |p|
      old_path = p.attachment.data.path.gsub("#{p.year}/publication", "2011/publication")
      if File.exist?(old_path)
        FileUtils.mkdir_p(p.attachment.data.path.gsub("#{p.id}-#{p.attachment.data_file_name}", ''))
        FileUtils.mv(old_path, p.attachment.data.path)
        puts p.attachment.data.path
      end
    end

    puts "Перенос вложений УП"

    Curriculum.where('year < 2011').each do |p|
      if p.attachment
        old_path = p.attachment.data.path.gsub("#{p.year}/curriculum", "2011/curriculum")
        if File.exist?(old_path)
          FileUtils.mkdir_p(p.attachment.data.path.gsub("#{p.id}-#{p.attachment.data_file_name}", ''))
          FileUtils.mv(old_path, p.attachment.data.path)
          puts p.attachment.data.path
        end
      end
    end
  end
end
