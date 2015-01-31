SHADOW_LENGTH = 1000

class LightSource
  attr_accessor :x, :y, :radius

  def initialize window, x, y, radius
    @att_sprite = Gosu::Image.new window, 'light.png', true
    @x = x
    @y = y
    @radius = radius
  end

  def shadow_circle window, circle
    dist = Gosu::distance @x, @y, circle.x, circle.y
    depth = 2.0 - dist / SHADOW_LENGTH

    bx1, by1, bx2, by2 = endpoints_facing circle.x, circle.y, @x, @y, circle.r

    nx1, ny1 = normal @x, @y, bx1, by1
    nx2, ny2 = normal @x, @y, bx2, by2

    sx1 = bx1 + nx1 * SHADOW_LENGTH
    sy1 = by1 + ny1 * SHADOW_LENGTH
    sx2 = bx2 + nx2 * SHADOW_LENGTH
    sy2 = by2 + ny2 * SHADOW_LENGTH

    window.gl depth do
      glDisable GL_DEPTH_TEST
      glEnable GL_BLEND
      glBlendEquationSeparate GL_FUNC_ADD, GL_FUNC_ADD
      glBlendFuncSeparate GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ZERO

      glBegin GL_QUADS
      glColor4f 0, 0, 0, 0.9
      glVertex3f bx1, by1, 0
      glColor4f 0, 0, 0, 0
      glVertex3f sx1, sy1, 0
      glVertex3f sx2, sy2, 0
      glColor4f 0, 0, 0, 0.9
      glVertex3f bx2, by2, 0
      glEnd
    end

    return depth
  end

  def draw_attenuation depth
    draw_as_rect @att_sprite, *clip_rect, depth, 0xff999999, :multiply
  end

  def clip window
    window.clip_to(*clip_rect) do
      yield
    end
  end

  private
  def endpoints_facing x1, y1, x2, y2, r
    a = Gosu::angle x1, y1, x2, y2
    x3 = x1 + Gosu::offset_x(a + 90, r)
    y3 = y1 + Gosu::offset_y(a + 90, r)

    x4 = x1 + Gosu::offset_x(a - 90, r)
    y4 = y1 + Gosu::offset_y(a - 90, r)

    [x3, y3, x4, y4]
  end

  def vector x1, y1, x2, y2
    dy = y2 - y1
    dx = x2 - x1
    [dx, dy]
  end

  def normal x1, y1, x2, y2
    d = Gosu::distance x1, y1, x2, y2
    x, y = vector x1, y1, x2, y2

    [x/d, y/d]
  end

  def clip_rect
    [(@x - @radius).to_i, (@y - @radius).to_i, (@radius*2.0).to_i, (@radius*2.0).to_i]
  end

  def draw_as_rect sprite, x, y, w, h, z, color, mode
    sprite.draw_as_quad x, y, color, x+w, y, color, x+w, y+h, color, x, y+h, color, z, mode
  end
end
