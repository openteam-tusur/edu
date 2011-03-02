# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :degree,
                 'Все квалификации',
                 collection_path(:query => params[:query],
                                 :chair_id => params[:chair_id]),
                 :highlights_on => /^((?!degree).)*$/

    @degree_facets.each do |facet|
      primary.item facet.value,
                   "#{Speciality.human_enum[:degree][facet.value.to_sym].mb_chars.capitalize} (#{facet.count})",
                   collection_path(:query => params[:query],
                                   :chair_id => params[:chair_id],
                                   :degree => facet.value),
                   :highlights_on => /degree=#{facet.value}/
    end
  end
end

