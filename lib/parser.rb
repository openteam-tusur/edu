# encoding: utf-8

class Parser
  def initialize(path, chair, encoding = 'cp1251')
    @doc = Nokogiri::XML(File.open(path))
    @doc.encoding = encoding

    @chair_slugs = YAML.load_file(Rails.root.join("config", "chairs.yml"))['chairs'][chair]
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

  def studies_with_education_attributes
    studies = {}

    @doc.xpath('//Документ/План/СтрокиПлана/Строка[@Цикл]').each do |node|
      code = node.attr('Цикл').match(/[БМС]\d|ФТД/).to_s

      chair_id = node.attr('Кафедра').to_i

      study = Plan::Study.new(:discipline_name => node.attr('Дис'),
                              :cycle_id => Plan::Cycle.where(:degree => speciality_degree, :code => code).first.id,
                              :chair_id => Chair.find_by_slug(@chair_slugs[chair_id]))

      studies.merge!(study => educations(node))
    end

    studies
  end

  def educations(node)
    result = {}

    if node.attr('СемЗач')
      node.attr('СемЗач').split(//).each do |semester_number|
        result[semester_number] ||= []
        result[semester_number] << Examination.find_by_slug('test')
      end
    end

    if node.attr('СемЭкз')
      node.attr('СемЭкз').split(//).each do |semester_number|
        result[semester_number] ||= []
        result[semester_number] << Examination.find_by_slug('examination')
      end
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
end

