class UsedBook < ActiveRecord::Base
  belongs_to :publication

  validates_presence_of :title, :kind

  attr_accessor :publication_title

  has_enum :kind
end
