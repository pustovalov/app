class NotificationsMailer < BaseMailer
  default from: NOREPLY_EMAIL

  def pending_cards(user)
    @user = user

    mail(to: @user.email, subject: 'You have the cards for check')
  end
end
