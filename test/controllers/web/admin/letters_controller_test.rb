require 'test_helper'

class Web::Admin::LettersControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :news
    @letter = create :letter
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'send_date', 'file']
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @letter.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Letter.all.map &:destroy
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create letter' do
    attributes = attributes_for :letter
    post :create, letter: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_letters_path
    letter = Letter.last
    letter.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], letter.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @letter
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :letter
    patch :update, letter: attributes, id: @letter
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_letter_path @letter
    @letter.reload
    @letter.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @letter.send(key), key
    end
  end

  test 'should delete destroy' do
    count = Letter.count
    delete :destroy, id: @letter
    assert_equal count - 1, Letter.count
  end
end
