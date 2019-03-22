class ContactsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contacts_mailer.feedback.subject
  #
  def feedback(feedback_attr)
    @message  = feedback_attr.message
    @email    = feedback_attr.email
    @subject  = feedback_attr.subject

    mail  from: @email,
          to: ENV['EMAIL_FOR_FEEDBACKS'],
          cc: @email,
          subject: t(".subject_prefix") + ":  #{@subject}",
          body: feedback_attr.message
  end
end
