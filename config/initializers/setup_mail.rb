ActionMailer::Base.smtp_settings = SETTINGS['mailer']['smtp_settings'].symbolize_keys
ActionMailer::Base.default_url_options = SETTINGS['mailer']['default_url_options'].symbolize_keys
Mail.register_interceptor(DevelopmentImperianMailInterceptor) if Rails.env.development? || Rails.env.test?
