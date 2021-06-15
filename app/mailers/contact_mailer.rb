class ContactMailer < ApplicationMailer
  def contact_mail(contact, user)
    @contact = contact
    mail to: user.email, subject: "Kchannelへのお問い合わせについて【自動送信メール】"
  end
end
