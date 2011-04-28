# encoding: utf-8

class Human < ActiveRecord::Base

  default_scope order('surname, name, patronymic')

  attr_accessor :post, :chair_id, :human_id

  belongs_to :user

  has_many :roles, :dependent => :destroy

  has_many :students, :class_name => 'Student'
  has_many :employees, :class_name => 'Employee'
  has_many :graduates, :class_name => 'Graduate'
  has_many :coauthors, :class_name => 'Coauthor'

  validates_presence_of :surname, :name, :patronymic
  validates_presence_of :post, :if => :chair_id
  validates_presence_of :human_id,
                        :if => :chair_id,
                        :on => :create,
                        :message => 'Необходимо выполнить проверку перед добавлением сотрудника или должности и выбрать действие'

  has_many :authors
  has_many :publications,
           :through => :authors,
           :source => :resource,
           :source_type => "Publication"

  protected_parent_of :publications, :user

  searchable do
    text :autocomplete, :as => :autocomplete_textp do full_name end
    text :full_name
    integer :employee_chair_ids, :multiple => true do
      employees.accepted.map(&:chair_id).compact
    end

    integer :chair_ids, :multiple => true, :references => Chair do
      roles.accepted.where("type <> 'Admin' AND type <> 'Student' AND type <> 'Graduate' AND type <> 'Coauthor'").map(&:chair_id).compact
    end

    string :role_slugs, :multiple => true do
      roles.accepted.map(&:slug).compact
    end

    string :surname
    string :name
    string :patronymic
  end

  def self.autocomplete_authors(query)
    solr_search do
      keywords query
    end.results
  end

  def accepted_employee_in_chair(chair)
    employees.accepted.where(:chair_id => chair.id).first
  end

  def full_name
    "#{surname} #{name} #{patronymic}"
  end

  def abbreviated_name
    "#{surname} #{name[0...1]}. #{patronymic[0...1]}."
  end

  def full_name_with_posts
    "#{full_name}#{posts}"
  end

  def posts
    roles.accepted.empty? ? "": " — #{roles.accepted.map(&:to_s).join(', ')}"
  end

  def has_publication?
    !publications.empty?
  end

  def namesakes
    human = self
    Human.solr_search do
      with :name, human.name
      with :patronymic, human.patronymic
      with :surname, human.surname
      without human
      paginate :per_page => 1000
    end.results
  end

  def to_s
    abbreviated_name
  end

  def merge_with(other_human)
    ActiveRecord::Base.transaction do
      other_human.roles.each do | role |
        role.update_attributes :human_id => self.id
      end
      other_human.authors.each do | author |
        author.update_attributes :human_id => self.id
      end
      if other_human.user_id
        if user_id
          other_human.user.destroy
        else
          self.update_attribute :user_id, other_human.user_id
          other_human.update_attribute :user_id, nil
        end
      end
      other_human.reload
      other_human.destroy
    end
  end

  def roles_with_type(type, accepted=nil)
    accepted ? roles.accepted.send(type) : roles.send(type)
  end

  def publications_grouped_by_kind
    publications.group_by(&:kind)
  end

  private

    def self.find_accepted_employees_in_chair(query, page, chair)
      solr_search do
        keywords query
        with :employee_chair_ids, chair.id
        order_by :surname
        order_by :name
        order_by :patronymic
        paginate :page => page, :per_page => 10
      end.results
     end

    def self.search(query, options)
      solr_search do
        keywords query

        chair_filter = with(:chair_ids, options[:chair_id]) if options[:chair_id]
        role_filter = with(:role_slugs, options[:role]) if options[:role]

        facet :chair_ids, :zeros => true, :exclude => chair_filter, :sort => :index
        facet :role_slugs, :zeros => true, :exclude => role_filter, :sort => :index

        paginate :page => options[:page], :per_page => 10
      end
    end

end


# == Schema Information
#
# Table name: humans
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  surname    :string(255)
#  name       :string(255)
#  patronymic :string(255)
#  created_at :datetime
#  updated_at :datetime
#

