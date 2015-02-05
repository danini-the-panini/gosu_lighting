module GosuLighting
  module Circle
    def draw_lit source
      self.draw source.shadow_circle self
    end
  end
end
