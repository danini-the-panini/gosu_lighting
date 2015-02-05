class TestRectangle < Struct.new(:x, :y, :width, :height)
  include GosuLighting::Rectangle

  def draw x
  end
end
