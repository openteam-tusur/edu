# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item "manage_chairs", t("title.manage/chairs.index"), manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/employees/ do |manage|

      manage.item "manage_chair_#{@chair.slug}", @chair.abbr,
                  manage_chair_path(@chair) do |chair|

        # список специальностей
        chair.item :specialities, t("title.manage/specialities.index"),
                    manage_chair_specialities_path(@chair) do |specialities|

          # специальности
          specialities.item :speciality, @speciality.title,
                      manage_chair_speciality_path(@chair, @speciality) do |speciality|
            speciality.item :edit_speciality, t("title.manage/specialities.edit"),
                          edit_manage_chair_speciality_path(@chair, @speciality)
            speciality.item :update_speciality, t("title.manage/specialities.edit"),
                          edit_manage_chair_speciality_path(@chair, @speciality),
                          :highlights_on => /specialities/ if params[:action] == "update" && params[:controller] == "manage/specialities"
            speciality.item :delete_speciality, t("title.manage/specialities.delete"),
                          delete_manage_chair_speciality_path(@chair, @speciality)

            # учебные планы
            speciality.item :curriculum, @curriculum.title,
                    manage_chair_speciality_curriculum_path(@chair, @speciality, @curriculum) do |curriculum|
              curriculum.item :edit_curriculum, t("title.manage/curriculums.edit"),
                            edit_manage_chair_speciality_curriculum_path(@chair, @speciality, @curriculum)
              curriculum.item :update_curriculum, t("title.manage/curriculums.edit"),
                            edit_manage_chair_speciality_curriculum_path(@chair, @speciality, @curriculum),
                            :highlights_on => /curriculum/ if params[:action] == "update" && params[:controller] == "manage/curriculums"
              curriculum.item :delete_curriculum, t("title.manage/curriculums.delete"),
                            delete_manage_chair_speciality_curriculum_path(@chair, @speciality, @curriculum)

              # семестры
              curriculum.item :curriculum, @semester.title,
                manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum, @semester) do |semester|
                semester.item :edit_semester, t("title.manage/semesters.edit"),
                              edit_manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum, @semester)
                semester.item :update_semester, t("title.manage/semesters.edit"),
                              edit_manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum, @semester),
                              :highlights_on => /semester/ if params[:action] == "update" && params[:controller] == "manage/semesters"
                semester.item :delete_semester, t("title.manage/semesters.delete"),
                              delete_manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum, @semester)

                # education
                if @education && @education.new_record?
                  semester.item :add_education, t("title.manage/educations.new"),
                              new_manage_chair_speciality_curriculum_semester_education_path(@chair, @speciality, @curriculum, @semester)
                  semester.item :create_education, t("title.manage/educations.new"),
                              new_manage_chair_speciality_curriculum_semester_education_path(@chair, @speciality, @curriculum, @semester),
                              :highlights_on => /education/ if params[:action] == "create" && params[:controller] == "manage/educations"
                end
                if @education && !@education.new_record?
                  semester.item :add_education, t("title.manage/educations.edit"),
                              edit_manage_chair_speciality_curriculum_semester_education_path(@chair, @speciality, @curriculum, @semester, @education)
                  semester.item :create_education, t("title.manage/educations.edit"),
                              edit_manage_chair_speciality_curriculum_semester_education_path(@chair, @speciality, @curriculum, @semester, @education),
                              :highlights_on => /education/ if params[:action] == "update" && params[:controller] == "manage/educations"
                  semester.item :delete_education, t("title.manage/educations.delete"),
                              delete_manage_chair_speciality_curriculum_semester_education_path(@chair, @speciality, @curriculum, @semester, @education)
                end
                # / education
              end if @semester && !@semester.new_record?
              if @semester && @semester.new_record?
                curriculum.item :add_semester, t("title.manage/semesters.new"),
                            new_manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum)
                curriculum.item :create_semester, t("title.manage/semesters.new"),
                            new_manage_chair_speciality_curriculum_semester_path(@chair, @speciality, @curriculum),
                            :highlights_on => /semester/ if params[:action] == "create" && params[:controller] == "manage/semesters"
              end
              # / семестры
            end if @curriculum && !@curriculum.new_record?

            if @curriculum && @curriculum.new_record?
              speciality.item :add_curriculum, t("title.manage/curriculums.new"),
                          new_manage_chair_speciality_curriculum_path(@chair, @speciality)
              speciality.item :create_curriculum, t("title.manage/curriculums.new"),
                          new_manage_chair_speciality_curriculum_path(@chair, @speciality),
                          :highlights_on => /curriculums/ if params[:action] == "create" && params[:controller] == "manage/curriculums"
            end
            # / учебные планы

          end if @speciality && !@speciality.new_record?

          if @speciality && @speciality.new_record?
            specialities.item :new_speciality, t("title.manage/specialities.new"),
                        new_manage_chair_speciality_path(@chair)
            specialities.item :create_speciality, t("title.manage/specialities.new"),
                        new_manage_chair_speciality_path(@chair),
                        :highlights_on => /specialities/ if params[:action] == "create" && params[:controller] == "manage/specialities"
          end

        end
        # / специальности

        # сотрудники кафедры
        chair.item :employees, t("title.manage/employees.index"),
                  manage_chair_employees_path(@chair) do |employees|
          if @employee && @employee.new_record?
            employees.item :add_employee, t("title.manage/employees.new"),
                        new_manage_chair_employee_path(@chair)
            employees.item :create_employee, t("title.manage/employees.new"),
                        new_manage_chair_employee_path(@chair),
                        :highlights_on => /employees/  if params[:action] == "create"
          end
          if @employee && !@employee.new_record?
            employees.item :edit_employee, t("title.manage/employees.edit"),
                        edit_manage_chair_employee_path(@chair, @employee)
            employees.item :edit_employee, t("title.manage/employees.edit"),
                        edit_manage_chair_employee_path(@chair, @employee),
                        :highlights_on => /employees/ if params[:action] == "update"
            employees.item :delete_employee, t("title.manage/employees.delete"),
                        delete_manage_chair_employee_path(@chair, @employee)
          end
        end

        # УМО
        chair.item :publications, t("title.manage/publications.index"),
            manage_chair_publications_path(@chair) do |publications|
          if @publication && @publication.new_record?
            publications.item :add_publication, t("title.manage/publications.new"),
                        new_manage_chair_publication_path(@chair)
            publications.item :create_publication, t("title.manage/publications.new"),
                        new_manage_chair_publication_path(@chair),
                        :highlights_on => /publications/  if params[:action] == "create"
          end
          if @publication && !@publication.new_record?
            publications.item :publication, @publication.title,
                        manage_chair_publication_path(@chair, @publication) do |publication|
              publication.item :edit_publication, t("title.manage/publications.edit"),
                          edit_manage_chair_publication_path(@chair, @publication)
              publication.item :edit_publication, t("title.manage/publications.edit"),
                          edit_manage_chair_publication_path(@chair, @publication),
                          :highlights_on => /publications/ if params[:action] == "update"
              if @publication_discipline && @publication_discipline.new_record?
                publication.item :add_discipline, t("title.manage/publication_disciplines.new"),
                          new_manage_chair_publication_publication_discipline_path(@chair, @publication)
                publication.item :add_discipline, t("title.manage/publication_disciplines.new"),
                          new_manage_chair_publication_publication_discipline_path(@chair, @publication),
                          :highlights_on => /publication_disciplines/  if params[:action] == "create"
              end
              if @publication_discipline && !@publication_discipline.new_record?
                publication.item :edit_discipline, t("title.manage/publication_disciplines.edit"),
                          edit_manage_chair_publication_publication_discipline_path(@chair, @publication)
                publication.item :edit_discipline, t("title.manage/publication_disciplines.edit"),
                          edit_manage_chair_publication_publication_discipline_path(@chair, @publication),
                          :highlights_on => /publication_disciplines/  if params[:action] == "update"
              end
            end
          end
        end
      # / УМО
      # Обеспечиваемые дисциплины
      chair.item :provided_specialities, t("title.manage/provided_specialities.index"),
                  manage_chair_provided_specialities_path(@chair)
      end if @chair
    end

    primary.item :humans,
                t("title.manage/humans.index"),
                manage_humans_path,
                :class => 'humans',
                :highlights_on => /manage\/humans/
  end
end

