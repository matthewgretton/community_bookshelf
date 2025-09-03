class Account < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_validation :normalize_email

  def current_magic_sgid
    to_sgid(for: "login:v#{login_token_version}")
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
