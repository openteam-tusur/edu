# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :main_page,
                 t('title.application.main_page'),
                 root_path do |secondary|

      secondary.item :training,
                     t('title.training.index'),
                     training_path do |training|

        training.item :specialities,
                      'Учебные планы для специальностей и направлений подготовки',
                      specialities_path do |speciality|

          speciality.item :curriculum,
                          "#{@curriculum.title}",
                          speciality_curriculum_path(@speciality, @curriculum) do |curriculum|

            curriculum.item :semester,
                            @semester.title,
                            speciality_curriculum_semester_path(@speciality, @curriculum, @semester) do |semester|

              semester.item :education,
                            @education.title,
                            speciality_curriculum_semester_education_path if @education
            end if @semester
          end if @curriculum
        end

        training.item :publications,
                      'Учебно-методическое обеспечение',
                      publications_path do |publication|
          publication.item :publication,
                           @publication.to_s,
                           publication_path(@publication) if @publication
        end

      end

      secondary.item :profile,
                     t('title.profile.index'),
                     profile_path

      secondary.item :humans,
                   t('title.humans.index'),
                   humans_path do |human|
        human.item :human,
                   @human.full_name,
                   human_path(@human) if @human
      end

      secondary.item :chairs,
                     t("title.chairs.index"),
                     chairs_path,
                     :class => "subfaculties" do |chairs|

          chairs.item "chair_#{@chair.slug}",
                      @chair.abbr,
                      chair_path(@chair) do |chair|

            chair.item :curriculums,
                       t("title.curriculums.index"),
                       chair_curriculums_path(@chair) do |curriculums|

              curriculums.item :curriculum,
                               @curriculum.title,
                               chair_curriculum_path(@chair, @curriculum) do |curriculum|

                curriculum.item :semester,
                                @semester.title,
                                chair_curriculum_semester_path(@chair, @curriculum, @semester) do |education|
                  education.item :education,
                                 @education.study.discipline.name,
                                 chair_curriculum_semester_education_path(@chair, @curriculum, @semester, @education) if @education
                end if @semester
              end if @curriculum
            end
          end if @chair
        end
      end
    end
end

