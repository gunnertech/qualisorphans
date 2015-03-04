class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@qualis.com"
  layout 'mailer'
end
