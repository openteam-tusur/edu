# encoding: utf-8

class Speciality < ActiveRecord::Base
  include AASM

  attr_accessor :semesters_count

  validates_presence_of     :chair, :code, :degree, :name, :qualification
  validates_numericality_of :semesters_count,
                            :only_integer => true,
                            :on => :create

  belongs_to  :chair

  has_many :disciplines, :class_name => "Plan::Discipline"

  has_one :licence, :class_name => "Plan::Licence"
  accepts_nested_attributes_for :licence

  has_one :accreditation, :class_name => "Plan::Accreditation"
  accepts_nested_attributes_for :accreditation

  has_many :semesters, :class_name => "Plan::Semester"

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
      self.semesters.find_or_create_by_number(number + 1)
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
#  state         :string(255)
#

