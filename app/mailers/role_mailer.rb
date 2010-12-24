# encoding: utf-8

class RoleMailer < ActionMailer::Base
  default :from => "portal@tusur.ru"

  def role_notification(role)
    @role = role
    mail( :to => SETTINGS['mailer']['admin_email'],
          :subject => "Заявка на роль #{role.title} от #{role.human.user.full_name}" )
  end

end

