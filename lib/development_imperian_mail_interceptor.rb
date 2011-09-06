class DevelopmentImperianMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = Settings['mailer']['admin_email']
  end

end

