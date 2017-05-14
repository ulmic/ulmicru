require 'test_helper'

class UsersGenderTest < ActionController::TestCase
  test 'check users gender' do
    if ENV['DB'] == 'prod'
      users = User.where(gender: nil)
      assert users.empty?, "Users with ids #{users.map(&:id)} has no gender :( It's not good :() )"
    end
  end
end
