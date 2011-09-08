mailer = Rails.configuration.action_mailer
mailer.register_interceptor(DevelopmentImperianMailInterceptor) if Settings['mailer.send_all_mail_to'].present?
mailer.default_url_options = { :host => Settings[:domain] }
mailer.smtp_settings = Settings['mailer.smtp_settings'].merge(:domain => Settings['domain'])
