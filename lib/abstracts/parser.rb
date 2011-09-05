# encoding: utf-8

require 'marc'

module Abstracts
  class Parser
    attr_accessor :path, :records

    def initialize(path)
      self.path = path
    end

    def topic_code
      parsed_filename[0..3]
    end

    def topic
      constants["topic"][parsed_filename[0..3].upcase]
    end

    def number
      parsed_filename[4..5]
    end

    def year
      parsed_filename[6..9]
    end

    def records
      @records ||= read_records
    end

    private

      def read_records
        data = File.open(path, "rb").read.gsub(/\r\n/, '')
        tempfile = Tempfile.new('abstracts', :encoding => 'ascii-8bit')
        tempfile.write(data)
        tempfile.flush
        tempfile.close
        MARC::Reader.new(File.open(tempfile.path, "r:cp866"), :forgiving => true).map do |marc|
          Record.new(:fields => marc.fields.inject({}) { |hash, field| hash.merge!(field) })
        end
      end

      def constants
        @constants ||= YAML::load(File.open("#{Rails.root}/config/abstracts.yml"))
      end

      def parsed_filename
        @parsed_filename ||= begin
                              original_filename = File.basename(path)
                              if original_filename.length < 14
                                 "#{original_filename[0..1]}00#{original_filename[2..(original_filename.length + 2)]}"
                              else
                                original_filename
                              end
                            end
      end

  end
end

