class SubscriptionMailer < ApplicationMailer
  def confirmation_email(user,orphan)
    @user = user
    @orphan = orphan
    mail(to: @user.email, bcc: "SamPetteway@suddenlink.net", subject: "Thank you for supporting #{orphan.organization.to_s}")
  end
end
