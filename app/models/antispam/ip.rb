module Antispam
  class Ip < ApplicationRecord
    def expired?
      self.expires_at < Time.now
    end
  end
end