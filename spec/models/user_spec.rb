# encoding: utf-8

require 'spec_helper'
require 'cancan/matchers'

describe User do
  it 'должен знать свои подтвержденые роли' do
    user = Factory.create(:user)
    user.human.save
    user.human.roles << Roles::Admin.new(:title => 'Администратор',
                                          :slug => 'admin',
                                          :state => 'accepted')

    user.reload.roles.should eql [:admin]
  end

  it 'не показывается уведомление если заполнен профиль и есть заявка' do
    user = Factory.create(:user)
    user.has_been_started?.should be false

    user.human.update_attributes(
      :surname => 'surname',
      :name => 'name',
      :patronymic => 'patronymic'
    )
    user.reload.has_been_started?.should be false

    user.human.students.create(:group => '425', :birthday => Date.today)
    user.reload.has_been_started?.should be true
  end
end



# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
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

