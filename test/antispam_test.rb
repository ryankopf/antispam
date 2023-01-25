require "test_helper"

class AntispamTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Antispam::VERSION
  end
  test "can check for spam" do
    assert_equal [1], Antispam::Tools.check_content_for_spam(content: "buy viagram from https://viagrasite.com")
  end
end
