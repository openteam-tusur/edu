require 'digest/md5'

class Attachment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true


  has_attached_file :data,
                    :url  => '/attachments/:id/download',
                    :path => ':rails_root/attachments/:chair_slug/:year/:resource_type/:resource_id-:filename'

  validates_attachment_content_type :data, :content_type => ['application/pdf']
  validates_uniqueness_of :data_hash

  before_validation :set_hash

  private
  def set_hash
    self.data_hash = Digest::MD5.hexdigest(self.data_file_size.to_s)
  end
end

# == Schema Information
#
# Table name: attachments
# Human name: Вложение
#
#  id                :integer         not null, primary key
#  data_uid          :string(255)
#  resource_id       :integer
#  data_file_name    :string(255)
#  data_file_size    :integer
#  data_content_type :string(255)
#  data_updated_at   :datetime
#  data_hash         :string(255)
#

