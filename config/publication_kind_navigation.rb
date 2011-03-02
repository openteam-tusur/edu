# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item :publications,
                 'Всё УМО',
                 collection_path(:query => params[:query]),
                 :highlights_on => /^((?!kind).)*$/

    @facets.each do |facet|
      primary.item facet.value,
                   Publication.human_attribute_name("kind_enum.#{facet.value}") + " (#{facet.count})",

                   collection_path(:chair_id => params[:chair_id],
                                   :with_comment => params[:with_comment],
                                   :kind => facet.value,
                                   :query => params[:query],
                                   :state => params[:state]),
                   :class => facet.value,
                   :highlights_on => /#{facet.value}/
    end
  end
end

