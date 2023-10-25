# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:production, :postmaster) || "from@example.com"
  layout "mailer"
end
