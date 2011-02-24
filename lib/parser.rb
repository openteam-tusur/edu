# encoding: utf-8

class Parser
  def initialize(path, encoding)
    @doc = Nokogiri::XML(File.open(path))
    @doc.encoding = encoding
  end

  def speciality
    spec = Speciality.find_by_code(speciality_code)

    unless spec
      spec = Speciality.create!(:name => speciality_name,
                                :code => speciality_code,
                                :qualification => speciality_qualification,
                                :degree => speciality_degree)
    end

    spec
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
end

