# encoding: utf-8

module Import
  class Importer
    def initialize(path, chairs_from, with_practics = true, print_messages = false)
      @parser = Import::Parser.new(path, chairs_from, with_practics)

      @print_messages = print_messages
    end

    def import
      ActiveRecord::Base.transaction do
        find_profiled_chair
        find_or_create_speciality
        create_curriculum
        create_studies_with_educations
      end
    end

    private
      def find_profiled_chair
        @chair = Chair.find_by_slug(@parser.profiled_chair_slug)
      end

      def find_or_create_speciality
        attributes = @parser.speciality_attributes

        @speciality ||= Speciality.find_by_code(attributes[:code])

        unless @speciality
          @speciality = Speciality.create!(:code => attributes[:code],
                                           :degree => attributes[:degree],
                                           :name => attributes[:name],
                                           :qualification => attributes[:qualification])
        end
      end

      def create_curriculum
        attributes = @parser.curriculum_attributes

        @curriculum = Plan::Curriculum.create!(:since => attributes[:since],
                                               :study => attributes[:study],
                                               :semesters_count => attributes[:semesters_count],
                                               :speciality_id => @speciality.id,
                                               :chair_id => @chair.id)
      end

      def create_studies_with_educations
        puts "#{@curriculum.title}" if @print_messages
        puts 'Добавление дисциплин:' if @print_messages

        @parser.attributes_for_studies_and_educations.each do |attributes|
          study = create_study(attributes)
          puts "\t#{study.discipline.name}" if @print_messages

          create_educations_for_study(study, attributes)
        end
      end

      def create_study(attributes)
        cycle = Plan::Cycle.find_by_code(attributes[:cycle_code])
        chair = Chair.find_by_slug(attributes[:chair_slug])

        study = Plan::Study.create!(:discipline_name => attributes[:discipline_name],
                                    :cycle_id => cycle.id,
                                    :chair_id => chair.id,
                                    :curriculum_id => @curriculum.id)
      end

      def create_educations_for_study(study, attributes)
        attributes[:semesters].each do |number, examinations|
          semester = @curriculum.semesters.find_by_number(number)

          education = study.educations.create!(:semester_id => semester.id,
                                               :study_id => study.id)

          examinations.each do |slug|
            education.examinations << Examination.find_by_slug(slug)
          end
        end
      end
  end
end
