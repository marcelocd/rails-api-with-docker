module Email
  extend ActiveSupport::Concern

  included do
    EMAIL_REGEXP     = URI::MailTo::EMAIL_REGEXP unless const_defined?(:EMAIL_REGEXP)
    MAX_EMAIL_LENGTH = 105                       unless const_defined?(:MAX_EMAIL_LENGTH)
  end
end
