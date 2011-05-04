# encoding: utf-8

class CrudController < ApplicationController
  inherit_resources
  render_inheritable

  protected
    def self.template_lookup_path(param = nil)
      ["crud/#{name.demodulize.gsub(/Controller$/, '').underscore}"] + super
    end

end
