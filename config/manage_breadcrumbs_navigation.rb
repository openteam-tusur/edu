# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    # список специальностей
    primary.item :specialities,
               t("title.manage/specialities.index"),
               manage_specialities_path do |specialities|

      # специальности
      specialities.item :speciality,
                        @speciality.title,
                        manage_speciality_path(@speciality) do |speciality|

        speciality.item :edit_speciality,
                        t("title.manage/specialities.edit"),
                        edit_manage_speciality_path(@speciality)

        speciality.item :update_speciality,
                        t("title.manage/specialities.edit"),
                        edit_manage_speciality_path(@speciality),
                        :highlights_on => /specialities/ if params[:action] == "update" && params[:controller] == "manage/specialities"

        speciality.item :delete_speciality,
                        t("title.manage/specialities.delete"),
                        delete_manage_speciality_path(@speciality)
      end if @speciality
    end

    primary.item "manage_chairs",
                 t("title.manage/chairs.index"),
                 manage_chairs_path,
                 :class => "subfaculties",
                 :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/employees/ do |manage|


      manage.item "manage_chair_#{@chair.slug}",
                  @chair.abbr,
                  manage_chair_path(@chair) do |chair|

        # список специальностей
        chair.item :specialities,
                   t("title.manage/specialities.index"),
                   manage_chair_curriculums_path(@chair) do |specialities|

          # учебные планы
          specialities.item :curriculum,
                          @curriculum.title,
                          manage_chair_curriculum_path(@chair, @curriculum) do |curriculum|

            curriculum.item :edit_curriculum,
                            t("title.manage/curriculums.edit"),
                            edit_manage_chair_curriculum_path(@chair, @curriculum)
            curriculum.item :update_curriculum,
                            t("title.manage/curriculums.edit"),
                            edit_manage_chair_curriculum_path(@chair, @curriculum),
                            :highlights_on => /curriculum/ if params[:action] == "update" && params[:controller] == "manage/curriculums"

            curriculum.item :delete_curriculum,
                            t("title.manage/curriculums.delete"),
                            delete_manage_chair_curriculum_path(@chair, @curriculum)

            # семестры
            curriculum.item :curriculum,
                            @semester.title,
                            manage_chair_curriculum_semester_path(@chair, @curriculum, @semester) do |semester|

              semester.item :edit_semester,
                            t("title.manage/semesters.edit"),
                            edit_manage_chair_curriculum_semester_path(@chair, @curriculum, @semester)
              semester.item :update_semester,
                            t("title.manage/semesters.edit"),
                            edit_manage_chair_curriculum_semester_path(@chair, @curriculum, @semester),
                            :highlights_on => /semester/ if params[:action] == "update" && params[:controller] == "manage/semesters"

              semester.item :delete_semester,
                            t("title.manage/semesters.delete"),
                            delete_manage_chair_curriculum_semester_path(@chair, @curriculum, @semester)

            end if @semester && !@semester.new_record?

            if @semester && @semester.new_record?
              curriculum.item :add_semester,
                              t("title.manage/semesters.new"),
                              new_manage_chair_curriculum_semester_path(@chair, @curriculum)

              curriculum.item :create_semester,
                              t("title.manage/semesters.new"),
                              new_manage_chair_curriculum_semester_path(@chair, @curriculum),
                              :highlights_on => /semester/ if params[:action] == "create" && params[:controller] == "manage/semesters"
            end
            # / семестры

            # study
            if @study && @study.new_record?
              curriculum.item :add_study,
                            t("title.manage/studies.new"),
                            new_manage_chair_curriculum_study_path(@chair, @curriculum)

              curriculum.item :create_study,
                            t("title.manage/studies.new"),
                            new_manage_chair_curriculum_study_path(@chair, @curriculum),
                            :highlights_on => /studies/ if params[:action] == "create" && params[:controller] == "manage/studies"
            end

            if @study && !@study.new_record?
              curriculum.item :edit_study,
                            t("title.manage/studies.edit"),
                            edit_manage_chair_curriculum_study_path(@chair, @curriculum, @study)

              curriculum.item :update_study,
                            t("title.manage/studies.edit"),
                            edit_manage_chair_curriculum_study_path(@chair, @curriculum, @study),
                            :highlights_on => /studies/ if params[:action] == "update" && params[:controller] == "manage/studies"

              curriculum.item :delete_study,
                            t("title.manage/studies.delete"),
                            delete_manage_chair_curriculum_study_path(@chair, @curriculum, @study)
            end
            # / study
          end if @curriculum && !@curriculum.new_record?

          if @curriculum && @curriculum.new_record?
            specialities.item :add_curriculum,
                            t("title.manage/curriculums.new"),
                            new_manage_chair_curriculum_path(@chair)

            specialities.item :create_curriculum,
                            t("title.manage/curriculums.new"),
                            new_manage_chair_curriculum_path(@chair),
                            :highlights_on => /curriculums/ if params[:action] == "create" && params[:controller] == "manage/curriculums"
          end
          # / учебные планы

        end
        # / специальности

        # сотрудники кафедры
        chair.item :employees,
                   t("title.manage/employees.index"),
                   manage_chair_employees_path(@chair) do |employees|

          if @employee && @employee.new_record?
            employees.item :add_employee,
                           t("title.manage/employees.new"),
                           new_manage_chair_employee_path(@chair)

            employees.item :create_employee,
                           t("title.manage/employees.new"),
                           new_manage_chair_employee_path(@chair),
                           :highlights_on => /employees/ if params[:action] == "create"
          end

          if @employee && !@employee.new_record?
            employees.item :edit_employee,
                           t("title.manage/employees.edit"),
                           edit_manage_chair_employee_path(@chair, @employee)

            employees.item :update_employee,
                           t("title.manage/employees.edit"),
                           edit_manage_chair_employee_path(@chair, @employee),
                           :highlights_on => /employees/ if params[:action] == "update"

            employees.item :delete_employee,
                           t("title.manage/employees.delete"),
                           delete_manage_chair_employee_path(@chair, @employee)
          end

        end

        # УМО
        chair.item :publications,
                   t("title.manage/publications.index"),
                   manage_chair_publications_path(@chair) do |publications|

          if @publication && @publication.new_record?
            publications.item :add_publication,
                              t("title.manage/publications.new"),
                              new_manage_chair_publication_path(@chair)

            publications.item :create_publication,
                              t("title.manage/publications.new"),
                              new_manage_chair_publication_path(@chair),
                              :highlights_on => /publications/ if params[:action] == "create"
          end

          if @publication && !@publication.new_record?
            publications.item :publication,
                              @publication.title,
                              manage_chair_publication_path(@chair, @publication) do |publication|

              publication.item :edit_publication,
                               t("title.manage/publications.edit"),
                               edit_manage_chair_publication_path(@chair, @publication)

              publication.item :update_publication,
                               t("title.manage/publications.edit"),
                               edit_manage_chair_publication_path(@chair, @publication),
                               :highlights_on => /publications/ if params[:action] == "update"

              if @publication_discipline && @publication_discipline.new_record?
                publication.item :add_discipline,
                                 t("title.manage/publication_disciplines.new"),
                                 new_manage_chair_publication_publication_discipline_path(@chair, @publication)

                publication.item :create_discipline,
                                 t("title.manage/publication_disciplines.new"),
                                 new_manage_chair_publication_publication_discipline_path(@chair, @publication),
                                 :highlights_on => /publication_disciplines/  if params[:action] == "create"
              end

              if @publication_discipline && !@publication_discipline.new_record?
                publication.item :edit_discipline,
                                 t("title.manage/publication_disciplines.edit"),
                                 edit_manage_chair_publication_publication_discipline_path(@chair, @publication)

                publication.item :update_discipline,
                                 t("title.manage/publication_disciplines.edit"),
                                 edit_manage_chair_publication_publication_discipline_path(@chair, @publication),
                                 :highlights_on => /publication_disciplines/ if params[:action] == "update"
              end

            end
          end
        end
      # / УМО

      # Обеспечиваемые дисциплины
      chair.item :grouped_provided_specialities,
                 t("title.manage/grouped_provided_specialities.index"),
                 manage_chair_grouped_provided_specialities_path(@chair) do |provided_specialities|

        provided_specialities.item :provided_curriculum,
               "#{@curriculum.chair.abbr} - #{@curriculum.speciality.title} - #{@curriculum.title}",
                manage_chair_curriculum_provided_educations_grouped_by_semesters_path(@chair, @curriculum) if @curriculum && !@curriculum.new_record?
      end

      # Книгообеспеченность
      chair.item :grouped_specialities,
                 t("title.manage/grouped_specialities.index"),
                 manage_chair_grouped_specialities_path(@chair) do |provision_specialities|
        provision_specialities.item :provision_curriculum,
                 "#{@curriculum.title}",
                 manage_chair_curriculum_provision_educations_grouped_by_semesters_path(@chair, @curriculum) if @curriculum && !@curriculum.new_record?
      end
    end if @chair

    end

    # люди
    primary.item "manage_humans",
                 t("title.manage/humans.index"),
                 manage_humans_path, :class => "humans",
                 :highlights_on => /^\/manage\/humans/ do |humans|

      if @human && @human.new_record?
        humans.item :new_human,
                    t("title.manage/humans.new"),
                    new_manage_human_path

        humans.item :create_human,
                    t("title.manage/humans.new"),
                    new_manage_human_path,
                    :highlights_on => /humans/ if params[:action] == "create" && params[:controller] == "manage/humans"
      end

      if @human && !@human.new_record?
        humans.item :human,
                    t("title.manage/humans.show"),
                    manage_human_path(@human)

        humans.item :edit_human,
                    t("title.manage/humans.edit"),
                    edit_manage_human_path(@human)

        humans.item :update_human,
                    t("title.manage/humans.edit"),
                    edit_manage_human_path(@human),
                    :highlights_on => /humans/ if params[:action] == "update"
      end
    end
    primary.item :abstracts,
               t("title.manage/disks.index"),
               manage_disks_path, :class => "disks",
                 :highlights_on => /^\/manage\/disks/ do |disks|

      disks.item :create_disk,
                  t("title.manage/disks.new"),
                  new_manage_disk_path,
                  :highlights_on => /^\/manage\/disks(\/new)?/ if @disk && @disk.new_record?

     if @disk && !@disk.new_record?
        disks.item :disk,
                    @disk.title,
                    manage_disk_issues_path(@disk),
                    :highlights_on => /^\/manage\/disks\/\d+/ do | disk |
          disk.item :create_issue,
                    t("title.manage/issues.new"),
                    new_manage_disk_issue_path(@disk),
                    :highlights_on => /^\/manage\/disks\/\d+\/issues(\/new)?/ if @issue && @issue.new_record?
        end
     end

    # УМО
    primary.item "manage_licenses",
                 t("title.manage/licenses.index"),
                 manage_licenses_path, :class => "lisences",
                 :highlights_on => /^\/manage\/licenses/ do |lisenses|

    end

   end
  end
end

