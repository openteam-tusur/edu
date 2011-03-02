# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :all_humans,
               'Все люди',
               collection_path(:query => params[:query], :chair_id => params[:chair_id]),
               :highlights_on => /^((?!role).)*$/

    @role_facets.each do |facet|
      primary.item facet.value,
                   t("roles.#{facet.value}") + " (#{facet.count})",
                   collection_path(:query => params[:query],
                                   :role => facet.value,
                                   :chair_id => params[:chair_id]),
                   :class => facet.value,
                   :highlights_on => /role=#{facet.value}/
    end
  end
end

