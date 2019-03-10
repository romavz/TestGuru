require 'test_helper'

class Admin::GistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_gist = admin_gists(:one)
  end

  test "should get index" do
    get admin_gists_url
    assert_response :success
  end

  test "should show admin_gist" do
    get admin_gist_url(@admin_gist)
    assert_response :success
  end

  test "should destroy admin_gist" do
    assert_difference('Admin::Gist.count', -1) do
      delete admin_gist_url(@admin_gist)
    end

    assert_redirected_to admin_gists_url
  end
end
