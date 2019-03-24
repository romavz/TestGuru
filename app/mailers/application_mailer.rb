class ApplicationMailer < ActionMailer::Base
  default from: %{"TestGuru" <zimovets.roman@gmail.com>}
  layout 'mailer'
end
