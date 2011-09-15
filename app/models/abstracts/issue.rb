# encoding: utf-8

class Issue < ActiveRecord::Base

  has_many :records

  belongs_to :disk


  has_attached_file :data,
                    :path => ':rails_root/issues/:issue_year/:issue_month/:issue_id-:filename'

  after_save :recreate_records

  delegate :year, :month, :to => :disk

  private

    def recreate_records
      records.destroy_all
      Abstracts::Parser.new(self.data.path).records.each  do | record |
        records.create!
        record.attributes
      end
    end

end





# == Schema Information
#
# Table name: issues
#
#  id                :integer         not null, primary key
#  created_at        :datetime
#  updated_at        :datetime
#  data_file_name    :string(255)
#  data_file_size    :integer
#  data_content_type :string(255)
#  data_updated_at   :datetime
#  data_hash         :string(255)
#  disk_id           :integer
#

