require 'test_helper'

class Web::MembersControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    sign_in @member
    @time_quantum = 1.seconds
  end

  test 'should not get new unsigned' do
    sign_out
    get :new
    assert_response :redirect, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create member' do
    @member.update state: :unavailable
    attributes = attributes_for :member
    [:first_name, :last_name, :patronymic, :ticket].each do |attribute|
      attributes[attribute] = @member.send attribute
    end
    create :event_registration
    create :comment
    create :authentication
    post :create, member: attributes
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    assert_equal attributes[:patronymic], Member.last.patronymic
  end

  test 'should get show' do
    unless Member.presented.count > 100
      @member.confirm
      get :show, ticket: @member.ticket
      assert_response :success, @response.body
    end
  end

  test 'should get show for all members' do
    tickets = Member.presented.map(&:ticket).compact
    tickets.reverse.each_with_index do |ticket, index|
      get :show, ticket: ticket
      assert_response :success, ticket
      print "#{index} of #{tickets.count}\r"
    end
  end

  test 'should get show for all members with time' do
    if ENV['DB'] == 'prod'
      sign_out
      tickets = Member.presented.map(&:ticket).compact
      tickets.reverse.each_with_index do |ticket, index|
        time = Time.now
        get :show, ticket: ticket
        duration = Time.now - time
        assert_response :success, ticket
        assert duration < @time_quantum, "#{duration} secs, Member with ticket #{ticket}"
        #print "#{index} of #{tickets.count}\r"
      end
    end
  end
end
