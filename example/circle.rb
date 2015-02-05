require 'gosu_lighting'

class Circle
  include GosuLighting::Circle

  attr_accessor :x, :y, :radius

  def initialize x, y, r, sprite, color = 0xffffffff
    @x = x
    @y = y
    @radius = r
    @sprite = sprite
    @color = color
  end

  def draw depth
    @sprite.draw_rot @x, @y, depth, 0, 0.5, 0.5, scale, scale, @color
  end

  private
  def scale
    @display_radius ||= @radius / (@sprite.width*0.5)
  end
end
