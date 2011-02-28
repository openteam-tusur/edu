# encoding: utf-8

class Parser
  def initialize(path, chairs_from, encoding = 'cp1251')
    @doc = Nokogiri::XML(File.open(path))
    @doc.encoding = encoding

    @chair_slugs = YAML.load_file(Rails.root.join("config", "chairs.yml"))['chairs'][chairs_from]
  end

  def speciality
    @speciality ||= Speciality.find_by_code(speciality_code)

    unless @speciality
      @speciality = Speciality.new(:name => speciality_name,
                                   :code => speciality_code,
                                   :qualification => speciality_qualification,
                                   :degree => speciality_degree)
    end

    @speciality
  end

  def curriculum
    @curriculum ||= Plan::Curriculum.new(:semesters_count => curriculum_semesters_count,
                                         :study => curriculum_study,
                                         :since => curriculum_since)
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

    result
  end

  private
    def speciality_name
      name = @doc.xpath('//Документ/План/Титул/Специальности/Специальность').first.attr('Название')
      name[name.index('-') + 1, name.length].strip
    end

    def speciality_code
      @doc.xpath('//Документ/План/Титул').first.attr('ПоследнийШифр')
    end

    def speciality_qualification
      @doc.xpath('//Документ/План/Титул/Квалификации/Квалификация').first.attr('Название')
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

    def semester_numbers_with_examinations(node)
      result = {}

      if node.attr('СемЗач')
        node.attr('СемЗач').split(//).each do |semester_number|
          result[semester_number.to_i] ||= []
          result[semester_number.to_i] << 'test'
        end
      end

      if node.attr('СемЭкз')
        node.attr('СемЭкз').split(//).each do |semester_number|
          result[semester_number.to_i] ||= []
          result[semester_number.to_i] << 'examination'
        end
      end

      result
    end
end

