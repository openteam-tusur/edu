# encoding: utf-8

class Speciality < ActiveRecord::Base

  attr_accessor :semesters_count

  validates_presence_of :code, :name, :qualification, :degree, :chair

  validates_numericality_of :semesters_count, :only_integer => true, :on => :create

  belongs_to :chair

  has_many :disciplines, :class_name => "Plan::Discipline"

  has_one :licence, :class_name => "Plan::Licence"
  accepts_nested_attributes_for :licence

  has_one :accreditation, :class_name => "Plan::Accreditation"
  accepts_nested_attributes_for :accreditation

  has_many :semesters, :class_name => "Plan::Semester"

  has_enum :degree, %w[specialist master bachelor]

  after_create :create_semesters

  def duration
    years = (semesters.count / 2).to_s
    result = (semesters.count % 2).zero? ? "#{years} " : "#{years},5 "
    result += I18n.t('speciality.duration', :count => semesters.count / 2)
  end

  private
  def create_semesters
    @semesters_count.to_i.times do |number|
      semesters.create(:number => number + 1)
    end
  end
end


# == Schema Information
#
# Table name: specialities
# Human name: Специальность
#
#  id            :integer         not null, primary key
#  name          :string(255)     'Название'
#  degree        :string(255)
#  qualification :string(255)
#  chair_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)
#

