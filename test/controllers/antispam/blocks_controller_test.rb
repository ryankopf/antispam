require "test_helper"

module Antispam
  class BlocksControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @block = antispam_blocks(:one)
    end

    test "should get index" do
      get blocks_url
      assert_response :success
    end

    test "should show block" do
      get block_url(@block)
      assert_response :success
    end

  end
end
