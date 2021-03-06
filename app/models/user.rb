# encoding: utf-8

class User < ActiveRecord::Base
  include Gravtastic
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  gravtastic :secure => true,
             :default => :identicon,
             :filetype => :gif,
             :size => 32

  default_scope order(:id)

  has_one :human, :inverse_of => :user

  alias :human_without_build :human

  def human
    human_without_build || build_human
  end

  def to_s
    email
  end

  # Возвращает список ролей пользователя
  def roles
    human.roles.accepted.collect { |r| r.slug.to_sym }
  end

  def has_been_started?
    !(human.new_record? || human.roles.empty?)
  end

end



# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
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

