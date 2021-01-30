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

    test "should get new" do
      get new_clear_url
      assert_response :success
    end

    test "should create clear" do
      assert_difference('Clear.count') do
        post clears_url, params: { clear: { answer: @clear.answer, ip: @clear.ip, result: @clear.result, threat_after: @clear.threat_after, threat_before: @clear.threat_before } }
      end

      assert_redirected_to clear_url(Clear.last)
    end

    test "should show clear" do
      get clear_url(@clear)
      assert_response :success
    end

    test "should get edit" do
      get edit_clear_url(@clear)
      assert_response :success
    end

    test "should update clear" do
      patch clear_url(@clear), params: { clear: { answer: @clear.answer, ip: @clear.ip, result: @clear.result, threat_after: @clear.threat_after, threat_before: @clear.threat_before } }
      assert_redirected_to clear_url(@clear)
    end

    test "should destroy clear" do
      assert_difference('Clear.count', -1) do
        delete clear_url(@clear)
      end

      assert_redirected_to clears_url
    end
  end
end
