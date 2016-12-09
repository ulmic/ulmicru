require 'test_helper'

class Web::Users::JoinControllerTest < ActionController::TestCase
  setup do
    user = create :user
    sign_in user
    @questionary = create :questionary
    create :article, :charter
    create :position_corporative_lead
    create :position_deputy_corporative_lead
  end

  test 'should get new' do
    corporate_header = create :member
    corporate_header.ticket = 238
    corporate_header.save
    get :new
    assert_response :success, @response.body
  end

  test 'should post create' do
    attributes = attributes_for :questionary
    post :create, questionary: attributes
    assert_response :redirect, @response.body
    assert_redirected_to account_path
    assert_equal attributes[:patronymic], Questionary.last.patronymic
  end

  test 'should not get create' do
    corporate_header = create :member
    corporate_header.ticket = 238
    corporate_header.save
    attributes = attributes_for :questionary
    attributes[:experience] = nil
    post :create, questionary: attributes
    assert_response :success, @response.body
    assert_not_equal attributes[:want_to_do], Questionary.last.want_to_do
  end
end
