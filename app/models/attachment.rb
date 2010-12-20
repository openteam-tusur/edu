class Attachment < ActiveRecord::Base
  has_attached_file :data
  
  validates_attachment_content_type :data, :content_type => ['application/pdf']
end
# == Schema Information
#
# Table name: attachments
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

