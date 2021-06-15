class ContactMailer < ApplicationMailer
  default from: "example@example.com"

  def contact_mail(contact, user)
    @contact = contact
    mail to: user.email, bcc: ENV["ACTION_MAILER_USER"], subject: "Kchannelへのお問い合わせについて【自動送信メール】"
    binding.pry
  end
end
