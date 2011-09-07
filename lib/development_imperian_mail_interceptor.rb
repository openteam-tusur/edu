class DevelopmentImperianMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = Settings['mailer.send_all_mail_to']
  end

end

