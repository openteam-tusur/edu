require 'digest/md5'

class Attachment < ActiveRecord::Base
  belongs_to :curriculum
  
  has_attached_file :data
  
  validates_attachment_content_type :data, :content_type => ['application/pdf']
  
  before_save :set_hash
  
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
#  curriculum_id     :integer
#

