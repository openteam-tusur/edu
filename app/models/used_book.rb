# encoding: utf-8

class UsedBook < ActiveRecord::Base
  belongs_to :publication

  validates_presence_of :title, :kind

  attr_accessor :publication_title

  has_enum :kind

  def to_s
    title
  end
end


# == Schema Information
#
# Table name: used_books
#
#  id               :integer         not null, primary key
#  title            :text
#  kind             :string(255)
#  publication_id   :integer
#  library_code     :string(255)
#  quantity         :integer
#  created_at       :datetime
#  updated_at       :datetime
#  publication_code :integer
#

