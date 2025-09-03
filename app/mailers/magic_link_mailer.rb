class MagicLinkMailer < ApplicationMailer
  def login_link(account, url)
    @account = account
    @url = url
    mail to: account.email, subject: "Your personal Community Bookshelf link"
  end
end
