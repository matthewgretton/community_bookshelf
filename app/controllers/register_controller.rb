class RegisterController < ApplicationController
  before_action :require_token_account!
  def index
  end
end
