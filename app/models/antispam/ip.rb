module Antispam
  class Ip < ApplicationRecord
    before_initialize :set_default_expires_at
    def expired?
      self.expires_at < Time.now
    end
    private
    def set_default_expires_at
      self.expires_at ||= 24.hours.from_now
    end
  end
end