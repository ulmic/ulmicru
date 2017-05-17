require 'test_helper'

class Web::Admin::ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = create :project
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get show' do
    get :show, id: @project.id
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ProjectDecorator.collections.each do |collection|
        pages = Project.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index with search' do
    get :index, search: @project.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Project.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create project' do
    attributes = attributes_for :project
    post :create, project: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_projects_path
    project = Project.last
    project.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], project.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @project
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :project
    patch :update, project: attributes, id: @project
    assert_response :redirect, @response.body
    assert_redirected_to admin_projects_path
    @project.reload
    @project.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @project.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @project
    @project.reload
    assert @project.removed?
  end
end
