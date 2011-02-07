# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :main_page,
                 t('title.application.main_page'),
                 root_path do |secondary|

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




              end if @curriculum
            end
          end if @chair
        end
      end
    end
end

