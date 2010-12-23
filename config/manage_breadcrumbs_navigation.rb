# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item "manage_chairs", "Кафедры", manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs|^\/manage\/humans/ do |manage|
      manage.item "manage_chair_#{@chair.slug}", @chair.abbr,
                  manage_chair_path(@chair) do |chair|
        chair.item :speciality, "#{@speciality.code} - #{@speciality.name}",
                    manage_chair_speciality_path(@chair, @speciality) if @speciality && !@speciality.new_record?
        chair.item :add_speciality, "Добавление специальности",
                    new_manage_chair_speciality_path(@chair)
        chair.item :edit_speciality, "Изменение специальности",
                    edit_manage_chair_speciality_path(@chair, @speciality) if @speciality
      end if @chair
    end
  end

end
