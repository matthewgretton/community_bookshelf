class SignupsController < ApplicationController
  before_action :require_no_account!, only: [:new, :create]
  def new
    @account = Account.new
  end

  def create
    normalized_email = signup_params[:email].to_s.strip.downcase
    existing = Account.find_by(email: normalized_email)

    if existing
      @account = existing
      created = false
    else
      @account = Account.new(signup_params)
      created = true
    end

    unless @account.persisted?
      return render(:new, status: :unprocessable_entity) unless @account.save
    end

    token = @account.current_magic_sgid
    url = search_url(token: token)
    MagicLinkMailer.login_link(@account, url).deliver_now
    if created
      redirect_to search_path(token: token)
    else
      redirect_to signup_path, notice: "We already have an account registered with that email. We've sent you another personal link."
    end
  end

  private

  def signup_params
    params.require(:account).permit(:name, :email, :mobile)
  end
end
