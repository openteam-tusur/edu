# encoding: utf-8

class RoleMailer < ActionMailer::Base
  default :from => "portal@tusur.ru"

  def role_create_notification(role)
    @role = role
    mail( :to => SETTINGS['mailer']['admin_email'],
          :subject => "Заявка на роль #{role.title} от #{role.human.user.full_name}" )
  end

  def role_update_notification(role)
    @role = role
    mail( :to => SETTINGS['mailer']['admin_email'],
          :subject => "В заявку на роль #{role.title} от #{role.human.user.full_name} внесены поправки" )
  end

end

