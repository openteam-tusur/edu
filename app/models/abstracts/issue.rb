# encoding: utf-8

class Issue < ActiveRecord::Base

  has_many :records


  has_attached_file :data,
                    :path => ':rails_root/issues/:issue_group/:issue_theme/:issue_year/:issue_month/:issue_id-:filename'

  after_save :recreate_records


 #/home/gdo/projects/tusur-portal
 #/issues/ololo/1/9999/14/12-ab01012007.iso

  def theme_group
    213
  end

  def theme
  '2'
  end

  def year
  '777'
  end

  def month
  '5'
  end


  private

    def recreate_records
      records.destroy_all
      Abstracts::Parser.new(self.data.path).records.each  do | record |
        records.create! record.attributes
      end
    end

end



# == Schema Information
#
# Table name: issues
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  data_file_name    :string(255)
#  data_file_size    :integer
#  data_content_type :string(255)
#  data_updated_at   :datetime
#  data_hash         :string(255)
#

