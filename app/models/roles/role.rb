# encoding: utf-8

require 'open-uri'

class Role < ActiveRecord::Base
  include AASM

  belongs_to :human
  belongs_to :chair

  default_scope order('id desc')

  delegate :name, :surname, :patronymic, :to => :human
  aasm_column :state

  aasm_initial_state :pending

  aasm_state :pending
  aasm_state :accepted
  aasm_state :rejected
  aasm_state :expired

  aasm_event :accept do
    transitions :from => :pending, :to => :accepted
  end

  aasm_event :reject do
    transitions :from => :pending, :to => :rejected
  end

  aasm_event :expire do
    transitions :from => :accepted, :to => :expired
  end

  after_save :reindex_human
  after_destroy :reindex_human

  after_create :send_create_notification, :if => Proc.new { |r| %w[Employee Postgraduate].include?(r.type)}
  after_update :send_update_notification, :if => Proc.new { |r| %w[Employee Postgraduate].include?(r.type)}

  class_eval do
    %w[admin employee graduate student].each do |role|
      scope role.to_sym, where(:type => role.capitalize)
    end
  end

  protected

    def check_by_contingent
      begin
        self.contingent_id = get_contingent_id
        if contingent_id
          accept!
          RoleMailer.check_by_contingent_successful_notification(self).deliver!
        else
          reject!
          RoleMailer.check_by_contingent_fault_notification(self).deliver!
        end
      rescue Exception => e # Net::HTTPResponse => e
        RoleMailer.service_not_responding.deliver!
      end
    end

    def reindex_human
      human.reload.index!
    end

    def get_contingent_id
      if contingent_response.is_a?(Array) && contingent_response.one?
        contingent_response.first['study_id']
      end
    end

    def contingent_response
      @contingent_response ||= JSON.parse(open("#{Settings['students.url']}/api/v1/students/?#{contingent_hash.to_param}").read)
    end

    def contingent_hash
      {
        :firstname  => name,
        :lastname   => surname,
        :patronymic => patronymic,
        :born_on    => birthday,
        :group      => group,
      }
    end

    def send_create_notification
      RoleMailer.role_create_notification(self).deliver!
    end

    def send_update_notification
      RoleMailer.role_update_notification(self).deliver!
    end
end


# == Schema Information
#
# Table name: roles
#
#  id            :integer         not null, primary key
#  human_id      :integer
#  title         :string(255)
#  slug          :string(255)
#  type          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)
#  group         :string(255)
#  birthday      :date
#  chair_id      :integer
#  post          :string(255)
#  contingent_id :integer
#

