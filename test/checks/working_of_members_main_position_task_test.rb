require 'test_helper'

class WorkingOfMembersMainPositionTaskTest < ActionController::TestCase
  test 'check updated_at of all confirmed members' do
    if ENV['DB'] == 'prod'
      count = Member.confirmed.count
      Member.confirmed.find_each.with_index do |member, index|
        assert_equal member.main_position&.title, member.decorate.main_position_title, member.id
        print "#{index} of #{count}\r"
      end
    end
  end
end
