require 'test_helper'

class Api::Admin::Delivery::ContactEmailsControllerTest < ActionController::TestCase
  setup do
    admin = create :admin
    sign_in admin
  end

  test 'should post create' do
    post :create, file: fixture_file_upload('1.xlsx', 'xlsx')
    assert_response :success
    (1..100).each do |i|
      assert Delivery::ContactEmail.where(email: "example@ulmic.ru#{i}").any?, "Contact Emails #{ i } not imported"
    end
  end
end
