require 'test_helper'

class WorkingOfMembersMainPositionTaskTest < ActionController::TestCase
  test 'check updated_at of all confirmed members' do
    if ENV['DB'] == 'prod'
      count = Member.confirmed.count
      Member.confirmed.find_each.with_index do |member, index|
        assert (Time.zone.now - member.updated_at) < 1.day, member.id
        print "#{index} of #{count}\r"
      end
    end
  end
end
