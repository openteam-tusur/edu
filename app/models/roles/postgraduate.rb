# encoding: utf-8

class Postgraduate < Role
  validates_presence_of :chair
  validates_uniqueness_of :chair_id, :scope => [:human_id, :state]

  default_values :title => 'Аспирант', :slug => 'employee'


  def to_s
    "#{title} каф. #{chair.abbr}"
  end
end

