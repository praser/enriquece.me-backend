# frozen_string_literal: true

# Defines a base to send emails through the app
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
