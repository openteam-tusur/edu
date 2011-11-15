# encoding: utf-8

require 'digest/md5'

class Issue < ActiveRecord::Base

  attr_accessor :skip_create_recrods

  has_many :records, :dependent => :destroy

  belongs_to :disk

  has_attached_file :data,
                    :path => ':rails_root/attachments/abstracts/:issue_year/:issue_month/:issue_id-:filename'

  before_validation :set_hash
  after_save :recreate_records, :unless => :skip_create_recrods

  validates_uniqueness_of :data_hash

  delegate :year, :month, :to => :disk

  default_scope :order => :data_file_name

  private

    def recreate_records
      records_count = 0
      imported_records_count = 0
      problem_subject_codes = []
      records.destroy_all
      Abstracts::Parser.new(self.data.path).records.each  do | record |
        record.issue = self
        record.save
        records_count += 1
        imported_records_count += 1 unless record.new_record?
        problem_subject_codes << record.subject_code if record.subject.new_record?
      end
      self.skip_create_recrods = true
      if problem_subject_codes.blank?
        self.update_attribute(:import_report, "Все записи успешно импортированны (#{imported_records_count})")
      else
        self.update_attribute(:import_report, "ВНИМАНИЕ! В некоторых записях есть неизвестные тематики!")
      end
    end

    def set_hash
      return unless self.data.file?
      self.data_hash = Digest::MD5.hexdigest(self.data_file_size.to_s)
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
#  import_report     :text
#
