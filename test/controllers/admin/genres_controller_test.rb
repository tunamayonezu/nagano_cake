require "test_helper"

class Admin::GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_genres_index_url
    assert_response :success
  end

  test "should get deit" do
    get admin_genres_deit_url
    assert_response :success
  end
end
