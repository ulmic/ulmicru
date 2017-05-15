require 'test_helper'

class Web::Admin::QuestionariesControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
    create :member
    @questionary = create :questionary
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'password_digest', 'birth_date', 'avatar', 'gender']
    create :position_corporative_lead
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @questionary.first_name
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      QuestionaryDecorator.collections.each do |collection|
        pages = Questionary.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index without instances' do
    Questionary.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should create questionary' do
    attributes = attributes_for :questionary
    post :create, questionary: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_questionary_path Questionary.last
    questionary = Questionary.last
    questionary.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], questionary.send(key), key
    end
    assert_equal GenderHelper.detect_gender(questionary.first_name).to_s, questionary.gender
  end

  test 'should get edit' do
    get :edit, id: @questionary
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :questionary
    patch :update, questionary: attributes, id: @questionary
    assert_response :redirect, @response.body
    assert_redirected_to admin_questionary_path @questionary
    @questionary.reload
    @questionary.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @questionary.send(key), key
    end
  end

  test 'should pass to organization' do
    attributes = attributes_for :questionary
    attributes[:member_state] = :confirmed
    patch :update, questionary: attributes, id: @questionary
    assert_response :redirect, @response.body
    assert_redirected_to edit_admin_member_path @questionary, message: :fill_member_form
    @questionary = Member.find @questionary.id
    @questionary.attributes.keys.except(*@exceptions_attributes).except('type', 'member_state').each do |key|
      assert_equal attributes[key.to_sym], @questionary.send(key), key
    end
    assert_equal @questionary.type, 'Member'
  end

  test 'should delete destroy' do
    count = Questionary.count
    delete :destroy, id: @questionary
    @questionary.reload
    assert @questionary.removed?
  end
end
