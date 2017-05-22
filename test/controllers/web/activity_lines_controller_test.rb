require 'test_helper'

class Web::ActivityLinesControllerTest < ActionController::TestCase
  setup do
    @activity_line = create :activity_line
  end

  test 'should get show' do
    get :show, id: @activity_line
    assert_response :success
  end

  test 'should get show all activity_lines' do
    if ENV['DB'] == 'prod'
      count = ActivityLine.count
      ActivityLine.find_each.with_index do |activity_line, index|
        print "#{index} of #{count}\r"
        get :show, id: activity_line.id
        assert_response :success
      end
    end
  end
end
