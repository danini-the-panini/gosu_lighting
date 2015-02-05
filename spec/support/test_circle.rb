class TestCircle < Struct.new(:x, :y, :radius)
  include GosuLighting::Circle

  def draw x
  end
end
