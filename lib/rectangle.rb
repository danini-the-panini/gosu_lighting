module GosuLighting
  module Rectangle
    def draw_lit source
      self.draw source.shadow_rectangle self
    end

    def center_x
      x + width * 0.5
    end

    def center_y
      y + height * 0.5
    end
  end
end
