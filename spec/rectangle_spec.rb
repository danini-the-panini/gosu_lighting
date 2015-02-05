require 'spec_helper'

describe GosuLighting::Rectangle do
  let(:window) { TestWindow.new }
  let(:rectangle) { TestRectangle.new 50, 80, 10, 20 }
  let(:source) { GosuLighting::Source.new window, 100, 100, 100, stub_sprite(window) }

  describe 'including' do
    context 'when rectangle implements draw, x, y, width and height' do
      it 'does not raise an exception' do
        expect {
          class GoodRect < Struct.new(:x, :y, :width, :height)
            include GosuLighting::Rectangle
            def draw x; end
          end
        }.to_not raise_error
      end
    end

    context 'when rectangle does not implement x, y, width and height' do
      it 'raises an exception' do
        expect {
          class BadRect
            include GosuLighting::Rectangle
            def draw x; end
          end
        }.to raise_error
      end
    end

    context 'when the rectangle does not implement draw' do
      it 'raises an exception' do
        expect {
          class BadRect < Struct.new(:x, :y, :width, :height)
            include GosuLighting::Rectangle
          end
        }.to raise_error
      end
    end

    context 'when the rectangle implements draw with no arguments' do
      it 'raises an exception' do
        expect {
          class BadRect < Struct.new(:x, :y, :width, :height)
            include GosuLighting::Rectangle
            def draw; end
          end
        }.to raise_error
      end
    end
  end

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
