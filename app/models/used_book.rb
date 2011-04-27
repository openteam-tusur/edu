class UsedBook < ActiveRecord::Base
  belongs_to :publication

  validates_presence_of :title, :kind

  has_enum :kind, %w[:additional :main]
end
