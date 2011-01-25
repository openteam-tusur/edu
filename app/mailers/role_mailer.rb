# encoding: utf-8

class RoleMailer < ActionMailer::Base
  default :from => "portal@tusur.ru"
  default :to => SETTINGS['mailer']['admin_email']

  def role_create_notification(role)
    @role = role
    mail( :subject => "Заявка на роль #{role.title} от #{role.human.full_name}" )
  end

  def role_update_notification(role)
    @role = role
    mail( :subject => "В заявку на роль #{role.title} от #{role.human.full_name} внесены поправки" )
  end

  def check_by_contingent_fault_notification(role)
    @role = role
    mail( :subject => "Возникли проблемы при поиске  #{role.title.downcase} #{role.human.full_name}" )
  end


end

