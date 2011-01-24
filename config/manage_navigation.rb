# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :manage_chairs, "<span class='decreased'>наши</span> кафедры",
                  manage_chairs_path, :class => "subfaculties",
                  :highlights_on => /^\/manage$|^\/manage\/chairs/
    primary.item :manage_human, "<span class='decreased'>наши</span> люди",
                  manage_humans_path, :class => "humans",
                  :highlights_on => /^\/manage\/humans/
  end

end
