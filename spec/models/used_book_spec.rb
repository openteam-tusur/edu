require 'spec_helper'

describe UsedBook do
  pending "add some examples to (or delete) #{__FILE__}"
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

