require 'spec_helper'

describe Publication do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: publications
# Human name: Публикация
#
#  id         :integer         not null, primary key
#  chair_id   :integer
#  title      :string(255)     'Название'
#  year       :integer         'Год издания'
#  volume     :integer         'Количество страниц'
#  state      :string(255)     'Статус'
#  access     :string(255)     'Доступ к файлу'
#  kind       :string(255)     'Тип учебного материала'
#  isbn       :string(255)     'ISBN'
#  udk        :string(255)     'УДК'
#  bbk        :string(255)     'ББК'
#  stamp      :string(255)     'Гриф'
#  created_at :datetime
#  updated_at :datetime
#

