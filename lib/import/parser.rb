# encoding: utf-8

module Import
  class Parser
    def initialize(path, chairs_from, encoding = 'cp1251')
      @doc = Nokogiri::XML(File.open(path))
      @doc.encoding = encoding

      @chair_slugs = YAML.load_file(Rails.root.join("config", "chairs.yml"))['chairs'][chairs_from]
    end

    def speciality_attributes
      { :code => speciality_code,
        :degree => speciality_degree,
        :name => speciality_name,
        :qualification => speciality_qualification }
    end

    def curriculum_attributes
      { :semesters_count => curriculum_semesters_count,
        :since => curriculum_since,
        :study => curriculum_study }
    end

    def attributes_for_studies_and_educations
      result = []

      @doc.xpath('//Документ/План/СтрокиПлана/Строка[@Цикл]').each do |node|
        discipline_name = node.attr('Дис')
        cycle_code = node.attr('Цикл').match(/[БМС]\d|ФТД/).to_s
        chair_slug = @chair_slugs[node.attr('Кафедра').to_i]

        result << {
          :discipline_name => discipline_name,
          :cycle_code => cycle_code,
          :chair_slug => chair_slug,
          :semesters => semester_numbers_with_examinations(node)
        }
      end

      result + practics
    end

    def profiled_chair_slug
      @chair_slugs[@doc.xpath('//Документ/План/Титул').first.attr('КодКафедры').to_i]
    end

    private
      def speciality_name
        name = @doc.xpath('//Документ/План/Титул/Специальности/Специальность').first.attr('Название')
        name[name.index('-') + 1, name.length].strip
      end

      def speciality_code
        @doc.xpath('//Документ/План/Титул').first.attr('ПолноеИмяПлана').split('-').first.gsub('_', '.')
      end

      def speciality_qualification
        @doc.xpath('//Документ/План/Титул/Квалификации/Квалификация').first.attr('Название').mb_chars.titleize.to_s
      end

      def speciality_degree
        case speciality_qualification.mb_chars.downcase.to_s
          when 'бакалавр' then 'bachelor'
          when 'магистр' then 'master'
          else 'undefined'
        end
      end

      def curriculum_semesters_count
        @doc.xpath('//Документ/План/Титул/Квалификации/Квалификация').first.attr('СрокОбучения').to_i * 2
      end

      def curriculum_study
        'fulltime'
      end

      def curriculum_since
        @doc.xpath('//Документ/План/Титул').first.attr('ГодНачалаПодготовки')
      end

      def semester_number(semester)
        if speciality_degree == 'master'
          case semester
            when '9' then return 1

            when '10' then return 2
            when 'A' then return 2

            when 'B' then return 3
            when 'C' then return 4
          end
        end

        return semester.to_i if semester.match(/\d/)
      end

      def semester_numbers_with_examinations(node)
        result = {}

        if node.attr('СемЗач')
          node.attr('СемЗач').split(//).each do |semester|
            result[semester_number(semester)] ||= []
            result[semester_number(semester)] << 'test'
          end
        end

        if node.attr('СемЭкз')
          node.attr('СемЭкз').split(//).each do |semester|
            result[semester_number(semester)] ||= []
            result[semester_number(semester)] << 'examination'
          end
        end

        result
      end

      def cycle_code_for_practic
        case speciality_degree
          when 'bachelor' then 'Б5'
          when 'master' then 'М3'
          else 'undefined'
        end
      end

      def practics
        result = []

        ['УчебПрактики', 'ПрочиеПрактики'].each do |practics|
          @doc.xpath("//Документ/План/СпецВидыРабот/#{practics}").children.each do |node|
            discipline_name = node.attr('Вид')
            chair_slug = @chair_slugs[node.attr('Кафедра').to_i]
            semester = semester_number(node.attr('Сем'))

            result << {
              :discipline_name => discipline_name,
              :cycle_code => cycle_code_for_practic,
              :chair_slug => chair_slug,
              :semesters => { semester => ['varied_test'] }
            }
          end
        end

        result
      end
  end
end

