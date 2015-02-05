require 'spec_helper'

describe GosuLighting::Source do
  let(:window) { TestWindow.new }
  let(:source) { GosuLighting::Source.new window, 100, 100, 100, stub_sprite(window) }
  let(:near_circle) { TestCircle.new 100, 90, 10 }
  let(:far_circle) { TestCircle.new 100, 10, 10 }

  describe '#draw' do
    it 'draws everything in a clipped area' do
      expect(window).to receive(:clip_to).with(0, 0, 200, 200)

      source.draw {  }
    end

    it 'yields itself to the block' do
      expect { |b| source.draw(&b) }.to yield_with_args(source)
    end
  end

  describe '#shadow_circle' do
    it 'returns a higher depth for closer circles' do
      near_depth = source.shadow_circle near_circle
      far_depth = source.shadow_circle far_circle

      expect(near_depth).to be > far_depth
    end
  end
end
