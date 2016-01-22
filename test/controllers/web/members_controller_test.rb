require 'test_helper'

class Web::MembersControllerTest < ActionController::TestCase
  setup do
    @member = create :member
    sign_in @member
    create :article, :contacts
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
    attributes = attributes_for :member
    attributes[:municipality] = Member.municipality.values.first
    attributes[:locality] = Member.locality.values.first
    create :event_registration
    create :comment
    create :authentication
    post :create, member: attributes
    assert_response :redirect, @response.body
    assert_redirected_to member_path attributes[:ticket]
    assert_equal attributes[:patronymic], Member.last.patronymic
  end

  test 'should get show' do
    create :event
    member = create :member
    registration = create :event_registration
    registration.user_id = member.id
    registration.save
    create :article
    tag = create :tag
    tag.record_id = Article.last.id
    tag.record_type = 'Article'
    tag.save
    member.member_state = 'confirmed'
    member.save
    create :news
    create :tag, :new_target
    get :show, ticket: member.ticket
    assert_response :success, @response.body
  end
end
