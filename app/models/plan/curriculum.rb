# encoding: utf-8
class Plan::Curriculum < ActiveRecord::Base
  set_table_name :plan_curriculums
  include AASM

  attr_accessor :semesters_count
  validates_numericality_of :semesters_count,
                            :only_integer => true,
                            :on => :create
  belongs_to :speciality

  has_one :attachment
  accepts_nested_attributes_for :attachment, :reject_if => :all_blank

  has_one :resource
  accepts_nested_attributes_for :resource, :reject_if => :all_blank

  has_many :semesters, :class_name => "Plan::Semester"

  validates_presence_of :speciality, :study
  validates_uniqueness_of :study, :scope => :speciality_id

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

  has_enum :study, %w[fulltime parttime postal]

  after_create :create_semesters

  def to_param
    self.study
  end

  def duration
    years = (semesters.count / 2).to_s
    result = (semesters.count % 2).zero? ? "#{years} " : "#{years},5 "
    result += I18n.t('curriculum.duration', :count => semesters.count / 2)
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
# Table name: plan_curriculums
# Human name: Учебный план
#
#  id            :integer         not null, primary key
#  study         :string(255)     'Форма обучения'
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)
#

