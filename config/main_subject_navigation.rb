# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :all_main_subjects,
                 'Все кафедры',
                 collection_path(:query => params[:query],
                                 :role => params[:role],
                                 :kind => params[:kind],
                                 :degree => params[:degree]),
                 :highlights_on => /^((?!chair_id).)*$/

    @chair_facets.each do |facet|
      primary.item facet.instance.slug,
                   "#{facet.instance.abbr} (#{facet.count})",
                   collection_path(:query => params[:query],
                                   :chair_id => facet.instance.id,
                                   :role => params[:role],
                                   :kind => params[:kind],
                                   :degree => params[:degree]),
                   :class => facet.instance.slug,
                   :highlights_on => /chair_id=#{facet.instance.id}$/
    end
  end
end

