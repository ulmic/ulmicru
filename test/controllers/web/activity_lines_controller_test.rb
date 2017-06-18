require 'test_helper'

class Web::ActivityLinesControllerTest < ActionController::TestCase
  setup do
    @activity_line = create :activity_line, activity_type: :central_program, organization_type: :ulmic, state: :active
  end

  test 'should get show' do
    get :show, id: @activity_line
    assert_response :success
  end

  test 'should get show all activity_lines' do
    if ENV['DB'] == 'prod'
      count = ActivityLine.count
      ActivityLine.active.ulmic.not_event_line.find_each.with_index do |activity_line, index|
        print "#{index} of #{count}\r"
        get :show, id: activity_line.id
        assert_response :success, activity_line.title
      end
    end
  end
end
