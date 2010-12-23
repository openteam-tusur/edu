class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  default_scope order(:id)

  has_one :human
  accepts_nested_attributes_for :human,
                                :reject_if => :all_blank,
                                :update_only => true

  after_create :create_human

  # Возвращает список ролей пользователя
  def roles
    if human
      human.roles.accepted.collect { |r| r.slug.to_sym }
    else
      []
    end
  end

  def has_been_started?
    human.filled? || human.roles.empty?
  end

end

# == Schema Information
#
# Table name: users
# Human name: Пользователь
#
#  id                   :integer         not null, primary key
#  email                :string(255)     'Электронная почта', default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

