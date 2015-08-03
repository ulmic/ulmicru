require 'test_helper'

class Web::Users::PositionsControllerTest < ActionController::TestCase
  setup do
    @position = create :position
    member = create :member
    sign_in member
    create :article, :contacts
  end

  test 'should create position' do
    attributes = attributes_for :position
    post :create, position: attributes
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    assert_equal attributes[:title], Position.last.title
  end

  test 'should patch update' do
    attributes = attributes_for :position
    patch :update, position: attributes, id: @position
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    @position.reload
    assert_equal attributes[:title], @position.title
  end

  test 'should delete destroy' do
    count = Position.count
    delete :destroy, id: @position
    assert_equal count - 1, Position.count
  end
end
