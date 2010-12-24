# encoding: utf-8
class WorkProgramm < Resource
  set_table_name :work_programms
  belongs_to :chair
  validates_presence_of :chair, :year, :access, :resource_name, :title, :attachment
  default_values :resource_name => "Рабочая программа"

end

# == Schema Information
#
# Table name: work_programms
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  year          :integer         'Год издания'
#  state         :string(255)     'Статус'
#  access        :string(255)     'Доступ к файлу'
#  resource_name :text            'Название файла'
#  created_at    :datetime
#  updated_at    :datetime
#  title         :text            'Название'
#

