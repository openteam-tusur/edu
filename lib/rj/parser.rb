# encoding: utf-8

module Rj
  class Parser

    def initialize(path)
      @constants = YAML::load(File.open("#{RAILS_ROOT}/config/rj_constants.yml"))
      @file = File.new(path, "r")
    end

    def topic_code
      prepare_filename(@file.original_filename)[0..3]
    end

    def topic
      key = prepare_filename(@file.original_filename)[0..3]
      @constants["topic"][key.upcase]
    end

    def number
      prepare_filename(@file.original_filename)[4..5]
    end

    def year
      prepare_filename(@file.original_filename)[6..9]
    end

    private

      def prepare_filename(original_filename)
        return "#{original_filename[0..1]}00#{original_filename[2..(original_filename.length + 2)]}" if original_filename.length < 14
        original_filename
      end

  end
end

