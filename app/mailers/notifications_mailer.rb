class NotificationsMailer < BaseMailer
  def pending_cards(user)
    @user = user

    mail(to: @user.email, subject: "You have the cards for check")
  end
end
