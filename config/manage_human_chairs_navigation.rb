# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    @chair_facets.each do |facet|
      primary.item facet.instance.slug,
                   "#{facet.instance.abbr} (#{facet.count})",
                   collection_path(:query => params[:query], 'chair_id' => facet.instance.id),
                   :class => facet.instance.slug,
                   :highlights_on => /chair_id=#{facet.instance.id}/
    end
  end
end

