module Antispam
  class Challenge < ApplicationRecord
    before_create :generate

    def generate
      self.question = create_string
      self.answer = self.question
    end
    def create_string
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      (0...8).map { o[rand(o.length)] }.join
    end
    def get_image
      require "image_processing/vips"
      # image = Vips::Image
      image = Vips::Image.text(self.answer, dpi: 300)
    end
  end
end