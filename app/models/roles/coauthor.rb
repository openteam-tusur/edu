# encoding: utf-8

class Roles::Coauthor < Role
  default_values :title => 'Соавтор', :slug => 'coauthor', :post => 'соавтор'

  def to_s
    title
  end
end

