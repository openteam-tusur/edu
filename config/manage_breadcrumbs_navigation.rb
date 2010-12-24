# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item "manage_chairs", t("title.manage/chairs.index"), manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/teachers/ do |manage|

      manage.item "manage_chair_#{@chair.slug}", @chair.abbr,
                  manage_chair_path(@chair) do |chair|



        # специальности
        chair.item :speciality, @speciality.title,
                    manage_chair_speciality_path(@chair, @speciality) do |speciality|
          speciality.item :edit_speciality, t("title.manage/specialities.edit"),
                        edit_manage_chair_speciality_path(@chair, @speciality)
          speciality.item :update_speciality, t("title.manage/specialities.edit"),
                        edit_manage_chair_speciality_path(@chair, @speciality),
                        :highlights_on => /specialities/ if params[:action] == "update"
          speciality.item :delete_speciality, t("title.manage/specialities.delete"),
                        delete_manage_chair_speciality_path(@chair, @speciality)
        end if @speciality && !@speciality.new_record?

        if @speciality && @speciality.new_record?
          chair.item :add_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair)
          chair.item :create_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair),
                      :highlights_on => /specialities/ if params[:action] == "create"
        end


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
