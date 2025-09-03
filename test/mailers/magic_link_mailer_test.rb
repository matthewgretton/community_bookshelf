require "test_helper"

class MagicLinkMailerTest < ActionMailer::TestCase
  test "login_link" do
    mail = MagicLinkMailer.login_link
    assert_equal "Login link", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
