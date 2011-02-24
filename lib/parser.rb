# encoding: utf-8

class Parser
  def initialize(path, encoding)
    @doc = Nokogiri::XML(File.open(path))
    @doc.encoding = encoding
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

