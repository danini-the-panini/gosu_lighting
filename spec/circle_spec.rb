require 'spec_helper'

describe GosuLighting::Circle do
  let(:window) { TestWindow.new }
  let(:circle) { TestCircle.new 50, 50, 10 }
  let(:source) { GosuLighting::Source.new window, 100, 100, 100, stub_sprite(window) }

  describe '#draw_lit' do
    it 'draws the shadow' do
      expect(source).to receive(:shadow_circle).with(circle)

      circle.draw_lit source
    end

    it 'draws the circle itself' do
      expect(circle).to receive(:draw).with(kind_of(Numeric))

      circle.draw_lit source
    end
  end
end
