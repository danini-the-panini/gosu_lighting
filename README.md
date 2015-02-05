Gosu Lighting
=============

Simple vector-based lighting for libgosu.

How to use
----------
```ruby
require 'gosu_lighting'

class MyCircle
  extend GosuLghting::Circle

  def draw
    # your own drawing logic
  end
end

# ... similar for rectangle

class MyGame < Gosu::Window
  def init
    @light_source = GosuLighting::Source.new x, y, radius
    @circle = MyCircle.new(...)
    @circle = MyRectangle.new(...)
  end

  def draw
    @light_source.draw do |l|
      @circle.draw_lit(l)
      @rectandle.draw_lit(l)
    end
  end
end
```

Limitations
-----------

1. Only handles circles and axis-aligned rectangles
2. Only really works with one light source

