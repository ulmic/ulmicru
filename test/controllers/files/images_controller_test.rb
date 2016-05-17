require 'test_helper'

class Files::ImagesControllerTest < ActionController::TestCase
  setup do
    @image = create :image
  end

  test 'should get show' do
    get :show, slug: @image.image.slug
    assert_response :success
  end
end
