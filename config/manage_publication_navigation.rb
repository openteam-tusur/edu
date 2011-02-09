# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    @facets.each do |facet|
      primary.item  facet.value,
                    Publication.human_attribute_name("kind_enum.#{facet.value}") + " (#{facet.count})",
                    collection_path(:query => params[:query], :kind => facet.value),
                    :class => facet.value,
                    :highlights_on => /#{facet.value}/
    end
  end
end

