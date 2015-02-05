require 'spec_helper'

describe GosuLighting::Circle do
  let(:window) { TestWindow.new }
  let(:circle) { TestCircle.new 50, 50, 10 }
  let(:source) { GosuLighting::Source.new window, 100, 100, 100, stub_sprite(window) }

  describe 'including' do
    context 'when circle implements draw, x, y and radius' do
      it 'does not raise an exception' do
        expect {
          class GoodCircle < Struct.new(:x, :y, :radius)
            include GosuLighting::Circle
            def draw x; end
          end
        }.to_not raise_error
      end
    end

    context 'when circle does not implement x, y and radius' do
      it 'raises an exception' do
        expect {
          class BadCircle
            include GosuLighting::Circle
            def draw x; end
          end
        }.to raise_error
      end
    end

    context 'when the circle does not implement draw' do
      it 'raises an exception' do
        expect {
          class BadCircle < Struct.new(:x, :y, :radius)
            include GosuLighting::Circle
          end
        }.to raise_error
      end
    end

    context 'when the circle implements draw with no arguments' do
      it 'raises an exception' do
        expect {
          class BadCircle < Struct.new(:x, :y, :radius)
            include GosuLighting::Circle
            def draw; end
          end
        }.to raise_error
      end
    end
  end

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
