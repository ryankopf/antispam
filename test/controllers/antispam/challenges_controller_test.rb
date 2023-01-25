require "test_helper"

module Antispam
  class ChallengesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @challenge = antispam_challenges(:one)
    end

    test "should get new" do
      get new_challenge_url
      assert_response :success
    end

    test "should show challenge" do
      get challenge_url(@challenge, format: :jpg)
      assert_response :success
    end

    test "should accept correct challenge" do
      patch challenge_url(@challenge), params: { challenge: { answer: @challenge.answer } }
      assert_redirected_to "/"
      #assert_redirected_to challenge_url(@challenge)
    end

    test "should deny invalid challenge" do
      patch challenge_url(@challenge), params: { challenge: { answer: "wronganswer" } }
      assert_redirected_to "/antispam/validate"
    end

  end
end
