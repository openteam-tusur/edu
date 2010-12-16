class Faculty < ActiveRecord::Base
  has_many :chairs
  default_scope order("id")
end

# == Schema Information
#
# Table name: faculties
# Human name: Факультет
#
#  id         :integer         not null, primary key
#  name       :string(255)     'Название'
#  abbr       :string(255)     'Аббревиатура'
#  slug       :string(255)     'Слаг'
#  created_at :datetime
#  updated_at :datetime
#

