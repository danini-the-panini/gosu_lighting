require 'gosu'
require 'glfw'
require 'opengl'

OpenGL.load_dll
GLFW.load_dll

include OpenGL
include GLFW

glfwInit

require_relative 'circle'
require_relative 'light_source'

class Lighting < Gosu::Window
  def initialize
    super 640, 480, false
    @ground_sprite = Gosu::Image.new self, 'ground.png', true
    @circle_sprite = Gosu::Image.new self, 'circle.png'
    @circles = 20.times.map do
      Circle.new(Gosu.random(0,640), Gosu.random(0,480), Gosu.random(5,30),
                 @circle_sprite, 0xffff00ff)
    end
    @light_source = LightSource.new self, 0, 0, 300
  end

  def update
    @light_source.x = mouse_x
    @light_source.y = mouse_y
  end

  def draw
    @light_source.clip(self) do
      grounds_x = width / @ground_sprite.width + 1
      grounds_y = height / @ground_sprite.height + 1
      grounds_x.times do |i|
        grounds_y.times do |j|
          @ground_sprite.draw i*@ground_sprite.width, j*@ground_sprite.height, 0
        end
      end
      @circles.each do |c|
        depth = @light_source.shadow_circle self, c
        c.draw depth
      end
    end
    @light_source.draw_attenuation 3
    light_bulb_scale = 3 / (@circle_sprite.width*0.5)
    @circle_sprite.draw @light_source.x - 3, @light_source.y - 3, 4,
      light_bulb_scale, light_bulb_scale
  end

  def needs_cursor?
    false
  end

end

Lighting.new.show
