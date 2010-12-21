class Users::RegistrationsController < Devise::RegistrationsController
  skip_authorization_check
end

