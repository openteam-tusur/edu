# encoding: utf-8

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    @state_facets.each do |facet|

      primary.item facet.value,
                   Publication.human_attribute_name("state_enum.#{facet.value}") + " (#{facet.count})",
                   collection_path(:chair_id => params[:chair_id],
                                   :with_comment => params[:with_comment],
                                   :kind => params[:kind],
                                   :query => params[:query],
                                   :state => facet.value),
                   :class => facet.value,
                   :highlights_on => /state=#{facet.value}/
    end


    primary.item :has_not_comment,
                 "С примечанием (#{@comment_facets[1].count})",
                 collection_path(:chair_id => params[:chair_id],
                                 :with_comment => true,
                                 :kind => params[:kind],
                                 :query => params[:query],
                                 :state => params[:state]),
                 :highlights_on => /with_comment=true/

    primary.item :has_not_comment,
                 "Все",
                 collection_path(:chair_id => params[:chair_id],
                                 :kind => params[:kind],
                                 :query => params[:query]),
                 :highlights_on => /^((?!with_comment).)*$/
  end
end

