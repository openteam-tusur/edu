# encoding: utf-8
class Plan::Curriculum < Resource

  set_table_name :plan_curriculums
  attr_accessor :semesters_count
  validates_numericality_of :semesters_count,
                            :only_integer => true,
                            :on => :create
  belongs_to :speciality
  delegate :chair, :to => :speciality

  has_many :semesters, :class_name => "Plan::Semester"

  validates_presence_of :speciality, :study, :since
  validates_uniqueness_of :study, :scope => [:speciality_id, :since]
  validates_presence_of :access, :resource_name, :year, :if => :attachment

  has_enum :study, %w[fulltime parttime postal]

  default_scope order('study')

  after_create :create_semesters

  def title
    "Учебный план (#{self.human_study} форма) с #{self.since} г."
  end

  def to_param
    self.slug
  end

  def slug
    "#{self.study}-#{self.since}"
  end

  def self.find_by_slug(slug)
    self.find_by_study_and_since(*slug.split("-"))
  end

  def duration
    years = (semesters.count / 2).to_s
    result = (semesters.count % 2).zero? ? "#{years} " : "#{years},5 "
    result += I18n.t('curriculum.duration', :count => semesters.count / 2)
  end

  def human_state
    I18n.t("attributes.state_enum.#{self.state}")
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
#  state         :string(255)     'Статус'
#  resource_name :string(255)     'Название файла'
#  year          :integer         'Год издания'
#  access        :string(255)     'Доступ к файлу'
#  since         :integer         'Действует с'
#

