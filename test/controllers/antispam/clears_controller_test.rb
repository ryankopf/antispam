require "test_helper"

module Antispam
  class ClearsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @clear = antispam_clears(:one)
    end

    test "should get index" do
      get clears_url
      assert_response :success
    end

    test "should show clear" do
      get clear_url(@clear)
      assert_response :success
    end

  end
end
