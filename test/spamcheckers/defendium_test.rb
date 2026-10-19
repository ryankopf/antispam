require 'minitest/autorun'
require 'minitest/mock'
require 'net/http'
require_relative '../../lib/antispam/spamcheckers/defendium'

class DefendiumTest < Minitest::Test
  def test_clean_content_returns_zero
    with_response('{"result":false}') do
      assert_equal 0, check
    end
  end

  def test_spam_content_returns_one
    with_response('{"result":true}') do
      assert_equal 1, check
    end
  end

  def test_result_word_in_a_message_is_not_a_spam_verdict
    with_response('{"message":"No result available"}') do
      assert_equal 0, check
    end
  end

  def test_logs_the_actual_warning
    logger = Minitest::Mock.new
    logger.expect :info, nil, ['API key warning']
    temporary_rails = !Object.const_defined?(:Rails)
    if temporary_rails
      Object.const_set(:Rails, Module.new)
      Rails.define_singleton_method(:logger) { nil }
    end

    Rails.stub :logger, logger do
      with_response('{"result":false,"warnings":"API key warning"}') do
        assert_equal 0, check
      end
    end
    logger.verify
  ensure
    Object.send(:remove_const, :Rails) if temporary_rails
  end

  private

  def check
    Antispam::Spamcheckers::Defendium.check('Example content', 'test-key', false)
  end

  def with_response(body)
    response = Net::HTTPOK.new('1.1', '200', 'OK')
    response.stub :body, body do
      Net::HTTP.stub :get_response, response do
        yield
      end
    end
  end
end
