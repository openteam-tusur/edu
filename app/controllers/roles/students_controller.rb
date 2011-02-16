# encoding: utf-8

require 'net/http'
require 'uri'

class Roles::StudentsController < RolesController
  load_and_authorize_resource :class => Roles::Student

  defaults :resource_class => Roles::Student,
           :instance_name => :roles_student

  def create
    parametrs = URI.escape(sprintf("lastname=%s&firstname=%s&patronymic=%s&group=%s&birth_date=%s",
                        current_user.human.surname,
                        current_user.human.name,
                        current_user.human.patronymic,
                        params[:roles_student][:group],
                        params[:roles_student][:birthday]))

    url = URI.parse("http://#{STUDENTS_HOST}/check?#{parametrs}")

    begin
      contingent_id = Net::HTTP.get(url)

      unless contingent_id.blank?
        current_user.human.roles << Roles::Student.new(params[:roles_student].merge(:contingent_id => contingent_id,
                                                                                    :state => :accepted))

        # TODO: посылать уведомление об успешном создании роли

      else
        current_user.human.roles << Roles::Student.new(params[:roles_student].merge(:contingent_id => contingent_id))
        # TODO: посылать уведомление о неудачном созданиее роли
      end
    rescue Exception => e
      # TODO: посылать уведомление о неработоспособности STUDENTS
      p e.message
    end

    redirect_to profile_path
  end
end

