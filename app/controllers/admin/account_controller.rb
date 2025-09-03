class Admin::AccountController < ApplicationController
  before_action :require_token_account!

  def show
    @account = current_account
    @magic_url = search_url(token: @account.current_magic_sgid)
  end

  def regenerate
    @account = current_account
    @account.increment!(:login_token_version)
    new_token = @account.current_magic_sgid
    redirect_to admin_root_path(token: new_token), notice: "Personal link regenerated"
  end
end
