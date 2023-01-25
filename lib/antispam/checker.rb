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
        if spamchecker_name == :defendium
          results.append Antispam::Spamcheckers::Defendium.check(options[:content], spamchecker_api_key, options[:verbose])
        end
      end
      result = Antispam::SpamcheckResult.new(results)
      return result
    end
  end
end