require 'test_helper'

class Web::JoinControllerTest < ActionController::TestCase
  setup do
    @questionary = create :questionary
    sign_in @questionary.user
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should post create' do
    attributes = attributes_for :questionary
    post :create, questionary: attributes
    assert_response :redirect, @response.body
    assert_redirected_to root_path
    assert_equal attributes[:patronymic], Member.last.patronymic
  end
end
