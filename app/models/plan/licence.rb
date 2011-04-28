# encoding: utf-8
class Licence < ActiveRecord::Base
  set_table_name :licences

  belongs_to :speciality

  def to_s
    result = ""
    result += self.number.blank? ? "№<span class='empty'>не указан</span>" : "№#{self.number}"
    result += " от "
    result += self.issued_on.blank? ? "<span class='empty'>не указано</span>" : "#{I18n.l self.issued_on}"
    result.html_safe
  end

end



# == Schema Information
#
# Table name: plan_licences
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)
#  issued_on     :date
#  created_at    :datetime
#  updated_at    :datetime
#

