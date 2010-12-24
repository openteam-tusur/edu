# encoding: utf-8
class Plan::Accreditation < ActiveRecord::Base
  set_table_name :plan_accreditations

  belongs_to :speciality

  def to_s
    result = ""
    result += self.number.blank? ? "№<span class='empty'>не указан</span>" : "№#{self.number}"
    result += " от "
    result += self.issued_at.blank? ? "<span class='empty'>не указано</span>" : "#{I18n.l self.issued_at}"
    result.html_safe
  end

end


# == Schema Information
#
# Table name: plan_accreditations
# Human name: Аккредитация
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)     'Номер'
#  issued_at     :date            'Дата выдачи'
#  created_at    :datetime
#  updated_at    :datetime
#

