# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    @role_facets.each do |facet|
      primary.item facet.value,
                   t("roles.#{facet.value}") + " (#{facet.count})",
                   collection_path(:query => params[:query], 'role' => facet.value),
                   :class => facet.value,
                   :highlights_on => /role=#{facet.value}/
    end
  end
end

