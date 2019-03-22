class ContactsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contacts_mailer.feedback.subject
  #
  def feedback(feedback_attr)
    @message = feedback_attr.message
    @email = feedback_attr.email

    mail  from: feedback_attr.email,
          to: ENV['EMAIL_FOR_FEEDBACK'],
          cc: @email,
          subject: "Feedback message for TestGuru web site"
  end
end
