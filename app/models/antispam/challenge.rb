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
      image = Vips::Image.text(self.answer, dpi: 300)
      image.draw_line(255, 5+rand(20).to_i, 5+rand(20).to_i, 150+rand(50).to_i, 10+rand(10).to_i)
    end
    def validate?(check)
      return false if self.answer.nil?
      result = false
      result = true if self.answer == check
      self.update_column(:answer,nil)
      return result
    end
  end
end
