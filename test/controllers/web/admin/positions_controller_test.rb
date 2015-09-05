require 'test_helper'

class Web::Admin::PositionsControllerTest < ActionController::TestCase
  setup do
    @position = create :position
  end

#  test 'should patch update' do
#    attributes = attributes_for :position
#    patch :update, position: attributes, id: @position
#    assert_response :redirect, @response.body
#    @position.reload
#    assert_equal attributes[:title], @position.title
#  end
#
#  test 'should delete destroy' do
#    delete :destroy, id: @position
#    @position.reload
#    assert @position.removed?
#    assert_response :redorect, @response.body
#  end
end
