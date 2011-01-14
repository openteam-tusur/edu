# encoding: utf-8
ActiveRecord::Base.instance_eval do
  def per_page
    10
  end
end
WillPaginate::ViewHelpers.pagination_options[:inner_window] = 2
WillPaginate::ViewHelpers.pagination_options[:previous_label] = "&larr;"
WillPaginate::ViewHelpers.pagination_options[:next_label] = "&rarr;"
Sunspot.config.pagination.default_per_page = 10

