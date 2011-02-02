# encoding: utf-8
require 'spec_helper'

describe Attachment do
  it "должен правильно ставить mime_type" do
    curriculum = Factory.create(:plan_curriculum)
    attachment = curriculum.build_attachment(:data => File.new(Rails.root + "spec/data/plan-210400.pdf"))
    attachment.save.should be true
    attachment.reload.data_content_type.should eql "application/pdf"
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
#  resource_type     :string(255)
#

