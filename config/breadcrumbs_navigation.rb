# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

  primary.item :chairs, t("title.chairs.index"), chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/chairs|^\/employees/ do |user|

      user.item "chair_#{@chair.slug}", @chair.abbr,
                  chair_path(@chair) do |chair|

        # список специальностей
        chair.item :specialities,
                   t("title.specialities.index"),
                   chair_specialities_path(@chair) do |specialities|

          # специальности
          specialities.item :speciality,
                            @speciality.title,
                            chair_speciality_path(@chair, @speciality) do |speciality|

           # учебные план
            speciality.item :curriculum,
                            @curriculum.title,
                            chair_speciality_curriculum_path(@chair, @speciality, @curriculum) do |curriculum|
              # семестр
              curriculum.item :semester,
                              @semester.title,
                              chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum, @semester) do |semester|
                semester.item :education, @education.discipline.name, "#" if @education
              end
            end if @curriculum
          end if @speciality
        end
      end if @chair
    end
  end
end

