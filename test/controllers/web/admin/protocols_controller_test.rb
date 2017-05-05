require 'test_helper'

class Web::Admin::ProtocolsControllerTest < ActionController::TestCase
  setup do
    @protocol = create :protocol
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'scan', 'document_id']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      ProtocolDecorator.collections.each do |collection|
        pages = Protocol.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index with search' do
    get :index, search: @protocol.title
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Protocol.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create protocol' do
    attributes = attributes_for :protocol
    post :create, protocol: attributes
    assert_response :redirect, @response.body
    assert_redirected_to admin_protocols_path
    protocol = Protocol.last
    protocol.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], protocol.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @protocol
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :protocol
    patch :update, protocol: attributes, id: @protocol
    assert_response :redirect, @response.body
    assert_redirected_to admin_protocols_path
    @protocol.reload
    @protocol.attributes.keys.except(*@exceptions_attributes).each do |key|
      raise key if attributes[key.to_sym].nil?
      assert_equal attributes[key.to_sym], @protocol.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @protocol
    @protocol.reload
    assert @protocol.removed?
  end
end
