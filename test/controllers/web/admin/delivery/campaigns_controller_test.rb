require 'test_helper'

class Web::Admin::Delivery::CampaignsControllerTest < ActionController::TestCase
  setup do
    @campaign = create :delivery_campaign
    admin = create :admin
    sign_in admin
    @exceptions_attributes = ['id', 'created_at', 'updated_at', 'image', 'creator_id', 'mailing_date']
  end

  test 'should get new' do
    get :new
    assert_response :success, @response.body
  end

  test 'should get index' do
    create_list :delivery_campaign, 5
    get :index
    assert_response :success, @response.body
  end

  test 'should get index all pages and tabs' do
    if ENV['DB'] == 'prod'
      Delivery::CampaignDecorator.collections.each do |collection|
        pages = Delivery::Campaign.send(collection).count / 25
        (pages + 2).times do |page|
          get :index, page: page
          assert_response :success
          print "Page #{page} of #{pages} of #{collection}\r"
        end
      end
    end
  end

  test 'should get index with search' do
    create_list :delivery_campaign, 5
    get :index, search: @campaign.link
    assert_response :success, @response.body
  end

  test 'should get index without instances' do
    Delivery::Campaign.destroy_all
    get :index
    assert_response :success, @response.body
  end

  test 'should create campaign' do
    attributes = attributes_for :delivery_campaign
    post :create, delivery_campaign: attributes
    assert_response :redirect, @response.body
    campaign = Delivery::Campaign.last
    assert_redirected_to admin_delivery_campaign_path campaign
    campaign.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], campaign.send(key), key
    end
  end

  test 'should get edit' do
    get :edit, id: @campaign
    assert_response :success, @response.body
  end

  test 'should patch update' do
    attributes = attributes_for :delivery_campaign
    patch :update, delivery_campaign: attributes, id: @campaign
    assert_response :redirect, @response.body
    assert_redirected_to admin_delivery_campaign_path @campaign
    @campaign.reload
    @campaign.attributes.keys.except(*@exceptions_attributes).each do |key|
      assert_equal attributes[key.to_sym], @campaign.send(key), key
    end
  end

  test 'should delete destroy' do
    delete :destroy, id: @campaign
    @campaign.reload
    assert @campaign.removed?
  end
end
