class ApplicationMailer < ActionMailer::Base
  default from: -> { Rails.application.credentials.dig(:mailer, :from) || "from@example.com" }
  layout "mailer"
end
