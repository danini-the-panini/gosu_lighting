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
    @circle_sprite = Gosu::Image.new self, 'circle.png'
    @circles = 20.times.map do
      Circle.new(Gosu.random(0,640), Gosu.random(0,480), Gosu.random(5,30),
                 @circle_sprite, 0xffff00ff)
    end
    @light_source = LightSource.new 0, 0
  end

  def update
    @light_source.x = mouse_x
    @light_source.y = mouse_y
  end

  def draw
    gl do
      glClearColor 1, 1, 1, 1.0
      glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
    end
    @circles.each do |c|
      @light_source.shadow_circle self, c
      c.draw 1
    end
  end

  def needs_cursor?
    true
  end

end

Lighting.new.show
