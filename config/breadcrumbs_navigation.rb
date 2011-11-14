# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :main_page,
                 t('title.application.main_page'),
                 root_path do |secondary|

      secondary.item :sign_in,
                     t('title.devise/sessions.new'),
                     user_session_path

      secondary.item :sign_up,
                     t('title.devise/registrations.new'),
                     new_user_registration_path

      secondary.item :password_new,
                     t('title.devise/passwords.new'),
                     new_user_password_path

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
                     profile_path do |profile|

        profile.item :edit_human,
                     t('title.profile.edit'),
                     edit_human_path

        profile.item :new_human,
                     t('title.humans.new'),
                     new_human_path

        profile.item :edit_user,
                     t('title.devise/registrations.edit'),
                     edit_user_registration_path

        if @student
          profile.item :new_student_role,
                       t('title.students.new'),
                       new_human_student_path

          profile.item :new_student_role,
                       t('title.students.new'),
                       human_students_path if params[:action] == "create" && params[:controller] == "students"
         end

        if @graduate
          profile.item :new_graduate_role,
                       t('title.graduates.new'),
                       new_human_graduate_path

          profile.item :new_graduate_role,
                       t('title.graduates.new'),
                       human_graduates_path if params[:action] == "create" && params[:controller] == "graduates"
         end


        profile.item :new_postgraduate_role,
                     t('title.postgraduates.new'),
                     new_human_postgraduate_path

        profile.item :new_employee_role,
                     t('title.employees.new'),
                     new_human_employee_path
      end

      secondary.item :humans,
                   t('title.humans.index'),
                   humans_path do |human|

        human.item :human,
                   @human.full_name,
                   human_path(@human) unless @human.nil? || @human.new_record?
      end

      secondary.item :records,
                   t('title.records.index'),
                   records_path do |record|

        record.item :record,
                   @record.title,
                   record_path(@record) unless @record.nil? || @record.new_record?
      end

      secondary.item :chairs,
                     t("title.chairs.index"),
                     chairs_path,
                     :class => "subfaculties" do |chairs|

          chairs.item "chair_#{@chair.slug}",
                      @chair.abbr,
                      chair_path(@chair) if @chair
      end
    end
  end
end

