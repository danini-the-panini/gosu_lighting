require 'spec_helper'

describe GosuLighting::Rectangle do
  let(:window) { TestWindow.new }
  let(:rectangle) { TestRectangle.new 50, 80, 10, 20 }
  let(:source) { GosuLighting::Source.new window, 100, 100, 100, stub_sprite(window) }

  describe '#draw_lit' do
    it 'draws the shadow' do
      expect(source).to receive(:shadow_rectangle).with(rectangle)

      rectangle.draw_lit source
    end

    it 'draws the circle itself' do
      expect(rectangle).to receive(:draw)

      rectangle.draw_lit source
    end
  end

  describe '#center_x' do
    it 'returns the center x' do
      expect(rectangle.center_x).to equal(55.0)
    end
  end

  describe '#center_y' do
    it 'returns the center y' do
      expect(rectangle.center_y).to equal(90.0)
    end
  end
end
