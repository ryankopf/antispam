require "test_helper"

class NavigationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "can get validate page" do
    get "/antispam/validate"
    assert_response :success
  end
  test "can not get gobblygook page" do
    assert_raise do
      get "/invalid_controller/validate"
    end
  end
  test "get index fine" do
    get "/"
    assert_response :success
  end
  test "get badip fine" do
    post "/badip"
    assert_redirected_to "/antispam/validate"
  end
  test "get goodip fine" do
    post "/goodip"
    assert_response :success
  end
end
