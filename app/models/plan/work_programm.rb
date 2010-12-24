class Plan::WorkProgramm < ActiveRecord::Base
  belongs_to :education, :class_name => "Plan::Education"
  belongs_to :human

  validates_presence_of :year, :human, :access, :resource_name
  validates_numericality_of :year, :only_integer => true

end
