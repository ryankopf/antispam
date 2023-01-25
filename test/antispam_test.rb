require "test_helper"

class AntispamTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Antispam::VERSION
  end
  test "can check for spam" do
    assert_equal true, Antispam::Checker.check({content: "buy viagra from https://viagrasite.com"}).is_spam?
  end
end
