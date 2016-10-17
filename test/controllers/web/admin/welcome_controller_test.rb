require 'test_helper'

class Web::Admin::WelcomeControllerTest < ActionController::TestCase
  setup do
    @types = [ :member, :questionary, :news, :article, :event, :feedback, :comment, :position ]
    @types.each do |type|
      type.to_s.camelize.constantize.delete_all
    end
  end

  test 'should get index' do
    admin = create :admin
    sign_in admin
    get :index
    assert_response :success, @response.body
  end
end
