# encoding: utf-8

class Speciality < ActiveRecord::Base
  include AASM

  attr_accessor :semesters_count

  validates_presence_of     :chair, :code, :degree, :name, :qualification
  validates_numericality_of :semesters_count, :only_integer => true, :on => :create

  belongs_to  :chair
  has_many    :disciplines
  has_many    :semesters

  has_one :licence
  accepts_nested_attributes_for :licence
  has_one :accreditation
  accepts_nested_attributes_for :accreditation

  has_enum :degree, %w[specialist master bachelor]

  aasm_column :state

  aasm_initial_state :unpublished

  aasm_state :unpublished
  aasm_state :published

  aasm_event :publish do
    transitions  :to => :published, :from => :unpublished
  end

  aasm_event :unpublish do
    transitions  :to => :unpublished, :from => :published
  end

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
#  degree        :string(255)     'Степень'
#  qualification :string(255)     'Квалификация'
#  chair_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)     'Код'
#

