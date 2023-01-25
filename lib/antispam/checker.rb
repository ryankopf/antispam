module Antispam
  module Checker
    # Checks content for spam
    # check(options)
    # Usage: check({content: "No spam here", providers: { defendium: 'MY_API_KEY'}})
    def self.check(options = {})
      # Default provider. 'YOUR_KEY' works temporarily, giving a warning but also giving results
      # eventually add something to tell users to add their own keys
      # or choose their preferred provider, when more provider options are added.
      options[:providers] ||= {defendium: 'YOUR_KEY'}
      Rails.logger.info "Content was nil for spamcheck." if options[:content].nil? && options[:verbose]
      return if options[:content].nil?
      Rails.logger.info "Spamcheckers should be a hash" if (!(options[:providers].is_a? Hash)) && options[:verbose]
      results = []
      options[:providers].each do |spamchecker_name, spamchecker_api_key|
        results.append spamchecker(spamchecker_name).check(options[:content], spamchecker_api_key, options[:verbose])
        # if spamchecker_name == :defendium
        #   results.append Antispam::Spamcheckers::Defendium.check(options[:content], spamchecker_api_key, options[:verbose])
        # end
      end
      result = Antispam::SpamcheckResult.new(results)
      return result
    end
    def self.spamchecker(provider)
      class_name = provider.to_s.camelize
      raise Antispam::NoSuchSpamcheckerError unless Antispam::Spamcheckers.const_defined? class_name
      Antispam::Spamcheckers.const_get class_name
    end
  end
  class NoSuchSpamcheckerError < StandardError; end
end