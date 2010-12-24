class DevelopmentImperianMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = SETTINGS['mailer']['admin_email'].symbolize_keys
  end

end

