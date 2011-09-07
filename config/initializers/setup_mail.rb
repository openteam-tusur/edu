ActionMailer::Base.smtp_settings = Settings['mailer.smtp_settings'].merge(:domain => Settings['domain'])
Mail.register_interceptor(DevelopmentImperianMailInterceptor) if Settings['mailer.send_all_mail_to'].present?

