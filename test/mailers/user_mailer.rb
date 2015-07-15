require 'test_helper'
require 'redis'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = create :user
  end

  test "check user email" do
    Redis.new.ping
    @user.generate_token

    assert_emails 1 do
      email = UserMailer.confirmation_instructions(@user).deliver_now
    end
    ap email
  end


end
