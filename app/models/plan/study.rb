# encoding: utf-8
class Plan::Study < ActiveRecord::Base
  set_table_name :plan_studies

  belongs_to :chair
  belongs_to :curriculum
  belongs_to :discipline

  has_many :educations, :class_name => "Plan::Education"
end

