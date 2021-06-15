class ContactMailer < ApplicationMailer
  default from: "example@example.com"

  def contact_mail(contact, user)
    @contact = contact
    if I18n.locale.to_s == "ja"
      mail to: user.email, bcc: ENV["ACTION_MAILER_USER"], subject: "Kchannelへのお問い合わせについて【自動送信メール】"
    else
      mail to: user.email, bcc: ENV["ACTION_MAILER_USER"], subject: "Kchannel로의 문의에 대해서【자동 송신】"
    end
  end
end
