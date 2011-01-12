# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item "manage_chairs", t("title.manage/chairs.index"), manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/teachers/ do |manage|

      manage.item "manage_chair_#{@chair.slug}", @chair.abbr,
                  manage_chair_path(@chair) do |chair|

        # список специальностей
        chair.item :specialities, t("title.manage/specialities.index"),
                    manage_chair_specialities_path(@chair)

        # специальности
        chair.item :speciality, @speciality.title,
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
          chair.item :add_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair)
          chair.item :create_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair),
                      :highlights_on => /specialities/ if params[:action] == "create" && params[:controller] == "manage/specialities"
        end
        # / специальности


        # сотрудники кафедры
        chair.item :teachers, t("title.manage/teachers.index"),
                  manage_chair_teachers_path(@chair) do |teachers|
          if @teacher && @teacher.new_record?
            teachers.item :add_teacher, t("title.manage/teachers.new"),
                        new_manage_chair_teacher_path(@chair)
            teachers.item :create_teacher, t("title.manage/teachers.new"),
                        new_manage_chair_teacher_path(@chair),
                        :highlights_on => /teachers/  if params[:action] == "create"
          end
          if @teacher && !@teacher.new_record?
            teachers.item :edit_teacher, t("title.manage/teachers.edit"),
                        edit_manage_chair_teacher_path(@chair, @teacher)
            teachers.item :edit_teacher, t("title.manage/teachers.edit"),
                        edit_manage_chair_teacher_path(@chair, @teacher),
                        :highlights_on => /teachers/ if params[:action] == "update"
          end
        end

        # рабочие программы
        chair.item :work_programms, t("title.manage/work_programms.index"),
            manage_chair_work_programms_path(@chair) do |work_programms|
          if @work_programm && @work_programm.new_record?
            work_programms.item :add_work_programm, t("title.manage/work_programms.new"),
                        new_manage_chair_work_programm_path(@chair)
            work_programms.item :create_teacher, t("title.manage/work_programms.new"),
                        new_manage_chair_work_programm_path(@chair),
                        :highlights_on => /work_programms/  if params[:action] == "create"
          end
          if @work_programm && !@work_programm.new_record?
            work_programms.item :work_programm, @work_programm.title,
                        manage_chair_work_programm_path(@chair, @work_programm)
            work_programms.item :edit_work_programm, t("title.manage/work_programms.edit"),
                        edit_manage_chair_work_programm_path(@chair, @work_programm)
            work_programms.item :edit_work_programm, t("title.manage/work_programms.edit"),
                        edit_manage_chair_work_programm_path(@chair, @work_programm),
                        :highlights_on => /teachers/ if params[:action] == "update"
          end
        end
      end if @chair
    end
  end

end
