require 'test_helper'

class Web::Users::AttributeAccessesControllerTest < ActionController::TestCase
  setup do
    member = create :member
    sign_in member.user
    @attribute_access = create :attribute_access
  end

  test 'should post create' do
    attributes = attributes_for :attribute_access
    post :create, attribute_access: attributes
    assert_response :success, @response.body
    assert_equal attributes[:member_attribute], AttributeAccess.last.member_attribute
  end

  test 'should not post create' do
    count = AttributeAccess.count
    attributes = attributes_for :attribute_access
    attributes[:member_id] = nil
    post :create, attribute_access: attributes
    assert_response :bad_request, @response.body
    assert_equal count, AttributeAccess.count
  end

  test 'should post create with update' do
    attributes = { member_id: @attribute_access.member_id, member_attribute: @attribute_access.member_attribute, access: 'visible' }
    post :create, attribute_access: attributes
    assert_response :success, @response.body
    @attribute_access.reload
    assert_equal attributes[:access], @attribute_access.access
  end

  test 'should not post create with update' do
    attributes = { member_id: @attribute_access.member_id, member_attribute: @attribute_access.member_attribute, access: nil }
    post :create, attribute_access: attributes
    assert_response :bad_request, @response.body
    @attribute_access.reload
    assert_not_equal attributes[:access], @attribute_access.access
  end
end
