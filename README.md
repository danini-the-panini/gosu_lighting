Gosu Lighting
=============

Simple vector-based lighting for libgosu.

How to use
----------

Include the Circle and Rectangle module into your own circle and rectangle classes. Your circle class _MUST_ have x, y, and radius properties, and your rectangle class _MUST_ have x, y, width, and height properties. Both your circle and rectangle classes must implement a `draw` method that takes a `depth` argument.

To draw circles and rectangles and everything with lighting and shadows, put it in the light source `draw` block and call the circle/rectangle `draw_lit` method with the light source instance, which is passed to the block for convenience.

Here's a trivial example:
```ruby
require 'gosu_lighting'

class MyCircle < Struct.new(:x, :y, :radius)
  include GosuLghting::Circle

  def draw
    # your own drawing logic
  end
end

class MyRectangle < Struct.new(:x, :y, :width, :height)
  include GosuLghting::Rectangle

  def draw
    # your own drawing logic
  end
end

class MyGame < Gosu::Window
  def init
    @light_source = GosuLighting::Source.new x, y, radius
    @circle = MyCircle.new(...)
    @rectangle = MyRectangle.new(...)
  end

  def draw
    @light_source.draw do |ls|
      @circle.draw_lit ls
      @rectandle.draw_lit ls
    end
  end
end
```

Limitations
-----------

1. Only handles circles and axis-aligned rectangles
2. Only really works with one light source

