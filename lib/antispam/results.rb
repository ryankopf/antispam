module Antispam
  class SpamcheckResult
    def initialize(results)
      @results = results
    end
    def is_spam?
      @results.select{|x| x > 0}.present?
    end
  end
end
