# encoding: utf-8

class Roles::Graduate < Role
  validates_presence_of :group, :birthday
  validates_uniqueness_of :human_id, :scope => [:contingent_id, :group]

  default_values :title => 'Магистрант', :slug => 'graduate', :post => 'Магистрант'

  after_create :check_by_contingent

  validate :find_same_role, :on => :create

  def to_s
    "магистрант гр. #{group}"
  end

  protected
    def find_same_role
      unless self.class.pending.where(:group => self.group, :birthday => self.birthday).empty?
        self.errors[:base] << "Ваша заявка находится на рассмотрении"
      end

      unless self.class.accepted.where(:group => self.group, :birthday => self.birthday).empty?
        self.errors[:base] << "Вы уже студент этой группы"
      end
    end
end


# == Schema Information
#
# Table name: roles
# Human name: Роль магистранта
#
#  id         :integer         not null, primary key
#  human_id   :integer
#  title      :string(255)
#  slug       :string(255)     'Слаг'
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)     'Статус'
#  group      :string(255)     'Группа'
#  birthday   :date            'Дата рождения'
#  chair_id   :integer
#  post       :string(255)     'Должность'
#

