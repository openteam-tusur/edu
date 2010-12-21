class Human < ActiveRecord::Base

  belongs_to :user

  has_many :roles

  def filled?
    surname.blank? && name.blank? && patronymic.blank?
  end

end

# == Schema Information
#
# Table name: humen
# Human name: Персональная информация
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  surname    :string(255)     'Фамилия'
#  name       :string(255)     'Имя'
#  patronymic :string(255)     'Отчество'
#  created_at :datetime
#  updated_at :datetime
#

