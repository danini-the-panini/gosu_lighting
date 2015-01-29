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
    @light_sprite = Gosu::Image.new self, 'light.png'
    @ground_sprite = Gosu::Image.new self, 'ground.png', true
    @circle_sprite = Gosu::Image.new self, 'circle.png'
    @circles = 20.times.map do
      Circle.new(Gosu.random(0,640), Gosu.random(0,480), Gosu.random(5,30),
                 @circle_sprite, 0xffff00ff)
    end
    @light_source = LightSource.new 0, 0, 300
  end

  def update
    @light_source.x = mouse_x
    @light_source.y = mouse_y
  end

  def draw
    #gl do
      #glClearColor 1, 1, 1, 1.0
      #glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
    #end
    light_area_x = @light_source.x - @light_source.radius
    light_area_y = @light_source.y - @light_source.radius
    clip_to(light_area_x, light_area_y, @light_source.radius*2.0, @light_source.radius*2.0) do
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
      light_scale_factor = @light_source.radius * 2.0 / @light_sprite.width
      @light_sprite.draw light_area_x, light_area_y, 3, light_scale_factor, light_scale_factor, 0xff999999, :multiply
    end
  end

  def needs_cursor?
    true
  end

end

Lighting.new.show
