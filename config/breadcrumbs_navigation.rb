# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :main_page,
                 t('title.application.main_page'),
                 root_path do |secondary|

      secondary.item :training,
                     t('title.training.index'),
                     training_path do |training|

        training.item :curriculums,
                      'Учебные планы',
                      curriculums_path

        training.item :publications,
                      'Учебно-методическое обеспечение',
                      publications_path

      end

      secondary.item :humans,
                   t('title.humans.index'),
                   humans_path

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

