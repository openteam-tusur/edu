ActionMailer::Base.smtp_settings = Settings[:mailer][:smtp_settings]
ActionMailer::Base.default_url_options = Settings[:mailer][:default_url_options]
Mail.register_interceptor(DevelopmentImperianMailInterceptor) if Rails.env.development? || Rails.env.test?

