class Month < ActiveRecord::Base
  belongs_to :year

  def number
    title.to_i
  end

  def localized_caption
    I18n.t('date.standalone_month_names')[number].mb_chars.downcase
  end
end

# == Schema Information
#
# Table name: months
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  year_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

