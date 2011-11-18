# encoding: utf-8

class Attachment < ActiveRecord::Base

  belongs_to :resource, :polymorphic => true

  has_attached_file :data,
                    :url  => '/attachments/:id-:resource_name/download',
                    :path => ':rails_root/attachments/:chair_slug/:year/:resource_type/:resource_id-:filename'

  validates_attachment_content_type :data, :content_type => ['application/pdf']

  validates_uniqueness_of :data_fingerprint

  before_validation :set_mime_type

  private

  def set_mime_type
    return unless self.data.file? && !data.queued_for_write[:original].nil?
    require 'filemagic'
    self.data_content_type =  MIME::Types[FileMagic.new(FileMagic::MAGIC_MIME).file(data.queued_for_write[:original].path)].first.content_type
  end

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
#  resource_type     :string(255)
#

