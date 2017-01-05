require 'test_helper'

class Web::Admin::TestPapersControllerTest < ActionController::TestCase
  setup do
    @test_paper = create :test_paper
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'begin_date', 'end_date']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index' do
    get :index
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @test_paper
    assert_response :success, @response.body
  end

  test 'should get index with search' do
    get :index, search: @test_paper.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    TestPaper.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create test_paper' do
    attributes = attributes_for :test_paper
    post :create, test_paper: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_test_papers_path
    test_paper = TestPaper.last
    test_paper.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], test_paper.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @test_paper
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :test_paper
    patch :update, test_paper: attributes, id: @test_paper
    assert_response :redirect, @response.body
    assert_redirected_to admin_test_papers_path
    @test_paper.reload
    @test_paper.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @test_paper.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @test_paper
    @test_paper.reload
    assert @test_paper.removed?
  end
end
