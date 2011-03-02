# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :manage_chairs, "<span class='decreased'>наши</span> кафедры",
                  manage_chairs_path, :id => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs/
    primary.item :manage_human, "<span class='decreased'>наши</span> люди",
                  manage_humans_path, :id => "humans",
                  :highlights_on => /^\/manage\/humans/
    primary.item :manage_specialities, "<span class='decreased'>наши</span> специальности",
                  manage_specialities_path, :id => "specialities",
                  :highlights_on => /^\/manage\/specialities/
  end

end

