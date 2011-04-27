class UsedBook < ActiveRecord::Base
  belongs_to :publication

  validates_presence_of :title, :kind

  has_enum :kind
end

# == Schema Information
#
# Table name: used_books
#
#  id             :integer         not null, primary key
#  title          :string(255)
#  kind           :string(255)
#  publication_id :integer
#  library_code   :string(255)
#  quantity       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

