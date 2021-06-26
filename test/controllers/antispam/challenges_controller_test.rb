require "test_helper"

module Antispam
  class ChallengesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @challenge = antispam_challenges(:one)
    end

    test "should get index" do
      get challenges_url
      assert_response :success
    end

    test "should get new" do
      get new_challenge_url
      assert_response :success
    end

    test "should show challenge" do
      get challenge_url(@challenge)
      assert_response :success
    end

    test "should update challenge" do
      patch challenge_url(@challenge), params: { challenge: { answer: @challenge.answer, code: @challenge.code, question: @challenge.question } }
      assert_redirected_to challenge_url(@challenge)
    end

  end
end
