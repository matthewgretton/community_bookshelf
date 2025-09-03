class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_account

  private

  def current_account
    return @current_account if defined?(@current_account)
    token = params[:token]
    return @current_account = nil if token.blank?

    # Tokens are generated with a versioned purpose: "login:v#{account.login_token_version}"
    # We may not know the version up front, so try a small range starting at 0.
    located = nil
    (0..5).each do |v|
      found = GlobalID::Locator.locate_signed(token, for: "login:v#{v}")
      if found.is_a?(Account)
        located = found
        break
      end
    end

    @current_account = located
  end

  def require_token_account!
    redirect_to signup_path unless current_account
  end

  def require_no_account!
    redirect_to search_path(token: params[:token]) if current_account
  end
end
