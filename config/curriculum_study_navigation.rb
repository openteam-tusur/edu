# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :studies,
                 'Все формы обучения',
                 collection_path(:query => params[:query],
                                 :chair_id => params[:chair_id]),
                 :highlights_on => /^((?!study).)*$/

    @study_facets.each do |facet|
      primary.item facet.value,
                   "#{Plan::Curriculum.human_enum[:study][facet.value.to_sym].mb_chars.capitalize} (#{facet.count})",
                   collection_path(:query => params[:query],
                                   :chair_id => params[:chair_id],
                                   :study => facet.value),
                   :highlights_on => /study=#{facet.value}/
    end
  end
end

