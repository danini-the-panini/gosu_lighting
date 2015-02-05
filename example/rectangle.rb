require 'gosu_lighting'

class Rectangle
  include GosuLighting::Rectangle
  attr_accessor :x, :y, :width, :height

  def initialize x, y, width, height, sprite, color = 0xffffffff
    @x = x
    @y = y
    @width = width
    @height = height
    @sprite = sprite
    @color = color
  end

  def draw depth
    @sprite.draw_as_quad @x, @y, @color,
      @x+@width, @y, @color,
      @x+@width, @y+@height, @color,
      @x, @y+@height, @color,
      3
  end

  def center_x
    @x + @width / 2
  end

  def center_y
    @y + @height / 2
  end
end
