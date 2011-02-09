# encoding: utf-8
class Plan::Curriculum < Resource

  set_table_name :plan_curriculums
  attr_accessor :semesters_count
  validates_numericality_of :semesters_count,
                            :only_integer => true,
                            :on => :create
  belongs_to :speciality
  belongs_to :chair

  has_many :semesters, :class_name => "Plan::Semester", :dependent => :destroy
  has_many :studies, :class_name => "Plan::Study"
  has_many :educations, :through => :semesters,
                        :class_name => "Plan::Education",
                        :include => :semester,
                        :order => 'plan_semesters.number'

  validates_presence_of :speciality, :study, :since
  validates_uniqueness_of :study, :scope => [:speciality_id, :since, :chair_id]
  validates_presence_of :access, :year, :attachment, :volume, :if => :need_all_resource_fields?

  protected_parent_of :educations, :protects => :softly

  has_enum :study, %w[fulltime parttime postal]

  default_scope order('study')
  scope :published,   where(:state => 'published')
  scope :unpublished, where(:state => 'unpublished')

  after_create :create_semesters

  def study_with_since
    "#{self.human_study} форма с #{self.since} г."
  end

  def since_with_study_form
    "учебный план набора #{self.since} года, #{self.human_study} форма обучения"
  end

  def title
    "#{speciality.short_title} (#{self.human_study} форма) с #{self.since} г."
  end

  def to_param
    self.slug
  end

  def slug
    "#{self.id}-#{self.speciality.code}-#{self.study}-#{self.since}"
  end

  def self.find_by_slug(slug)
    self.find(slug.split("-")[0])
  end

  def semesters_count
    self.semesters.count
  end

  def cources_count
    (self.semesters_count / 2) + (self.semesters_count % 2)
  end

  def duration
    years = (semesters.count / 2).to_s
    result = (semesters.count % 2).zero? ? "#{years} " : "#{years},5 "
    result += ::I18n.t('curriculum.duration', :count => semesters.count / 2)
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
#  speciality_id :integer         'Направление подготовки (специальность)'
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)     'Статус'
#  year          :integer         'Год издания'
#  access        :string(255)     'Доступ к файлу'
#  since         :integer         'Действует с'
#  volume        :integer         'Количество страниц'
#  chair_id      :integer
#

