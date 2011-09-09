# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :pending, 'Подвисшие:', '', :highlights_on => /######################/

    @pending_role_facets.each do |facet|
      primary.item facet.value,
                   t("roles.#{facet.value}") + " (#{facet.count})",
                   collection_path(:query => params[:query],
                                   :pending_role => facet.value,
                                   :chair_id => params[:chair_id]),
                   :class => facet.value,
                   :highlights_on => /pending_role=#{facet.value}/
    end
  end
end

