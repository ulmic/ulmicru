require 'test_helper'

class Web::Members::Corporative::PetitionsControllerTest < ActionController::TestCase
  CONFESSION_DATES = configus.dates.activity_lines.corporative.confession

  setup do
    member = create :member, member_state: :confirmed
    sign_in member
    @petition = create :petition, creator_id: current_user.id
    page = :confession_submissions_petitions_ends
    create :page, slug: page, view: page
    @exceptions_attributes = [ 'id', 'created_at', 'updated_at' ]
    create :article, :contacts
  end

  test 'should create petition' do
    attributes = attributes_for :petition
    attributes[:creator_id] = current_user.id
    attributes[:arguments_attributes] = { '0' => attributes_for(:argument) }
    post :create, activity_lines_corporative_confession: attributes
    if DateTime.now > CONFESSION_DATES.begining_submissions_petitions &&
      DateTime.now < CONFESSION_DATES.ending_submissions_petitions
      assert_response :redirect, @response.body
      petition = ::ActivityLines::Corporative::Confession.last
      petition.attributes.keys.except(*@exceptions_attributes).each do |key|
        assert_equal attributes[key.to_sym], petition.send(key), key
      end
    else
      assert_redirected_to page_page_path :not_found
    end
  end

  test 'should get new' do
    get :new
    if DateTime.now < CONFESSION_DATES.begining_submissions_petitions
      assert_response :redirect, @response.body
      assert_redirected_to page_page_path :not_found
    elsif DateTime.now > CONFESSION_DATES.ending_submissions_petitions
      assert_response :redirect, @response.body
      assert_redirected_to page_page_path :confession_submissions_petitions_ends
    else
      assert_response :success
    end
  end

  test 'should patch update' do
    attributes = attributes_for :petition
    attributes[:creator_id] = current_user.id
    patch :update, activity_lines_corporative_confession: attributes, id: @petition
    if DateTime.now > CONFESSION_DATES.begining_submissions_petitions &&
      DateTime.now < CONFESSION_DATES.ending_submissions_petitions
      assert_redirected_to members_corporative_petitions_path
      @petition.reload
      @petition.attributes.keys.except(*@exceptions_attributes).each do |key|
        assert_equal attributes[key.to_sym], @petition.send(key), key
      end
    else
      assert_response :redirect, @response.body
      assert_redirected_to page_page_path :not_found
    end
  end
end
