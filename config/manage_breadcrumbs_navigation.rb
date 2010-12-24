# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item "manage_chairs", t("title.manage/chairs.index"), manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/teachers/ do |manage|

      manage.item "manage_chair_#{@chair.slug}", @chair.abbr,
                  manage_chair_path(@chair) do |chair|



        chair.item :speciality, @speciality.title,
                    manage_chair_speciality_path(@chair, @speciality) do |speciality|
          speciality.item :edit_speciality, t("title.manage/specialities.edit"),
                        edit_manage_chair_speciality_path(@chair, @speciality)
          speciality.item :update_speciality, t("title.manage/specialities.edit"),
                        edit_manage_chair_speciality_path(@chair, @speciality),
                        :highlights_on => /specialities/ if params[:action] == "update"
        end if @speciality && !@speciality.new_record?

        if @speciality && @speciality.new_record?
          chair.item :add_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair)
          chair.item :create_speciality, t("title.manage/specialities.new"),
                      new_manage_chair_speciality_path(@chair),
                      :highlights_on => /specialities/ if params[:action] == "create"
        end


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
      end if @chair
    end
  end

end
