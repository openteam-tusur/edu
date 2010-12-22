# encoding: utf-8

module ApplicationHelper
  def title_locale
    title(t("title.#{params[:controller]}.#{params[:action]}"), true)
    t("title.#{params[:controller]}.#{params[:action]}")
  end

  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def l(value, options={})
    value ? I18n.l(value, options) : I18n.t(:'show_for.blank', :default => "Not specified")
  end

  def show_notice
    %w(notice alert).map do | field |
      unless controller.send(field).blank?
        content = ""
        content_tag :div, :class => "flash_block #{field}" do | div |
          content += link_to "закрыть", "#"
          content += content_tag :p, controller.send(field)
          content.html_safe
        end
      end
    end.join.html_safe
  end

end

