module Antispam
  module Checker
    # Checks content for spam
    # check(options, spamcheck_providers)
    # Usage: check({content: "No spam here"}, {defendium: 'MY_API_KEY'}})
    def self.check(options = {}, spamcheck_providers = {defendium: 'YOUR_KEY'})
      Rails.logger.info "Content was nil for spamcheck." if options[:content].nil? && options[:verbose]
      return if options[:content].nil?
      Rails.logger.info "Spamcheckers should be a hash" if (!(options[:spamcheck_providers].is_a? Hash)) && options[:verbose]
      results = []
      spamcheck_providers.each do |spamchecker_name, spamchecker_api_key|
        if spamchecker_name == :defendium
          results.append Antispam::Spamcheckers::Defendium.check(options[:content], spamchecker_api_key, options[:verbose])
        end
      end
      result = Antispam::SpamcheckResult.new(results)
      return result
    end
  end
end