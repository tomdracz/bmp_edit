require_relative '../lib/bitmap'

describe Bitmap do
  describe "#initialize" do
    it "sets width and height of bitmap" do
      bitmap = described_class.new(2,2)
      expect(bitmap.width).to eq(2)
      expect(bitmap.height).to eq(2)
    end

    it "sets the pixels matrix" do
      bitmap = described_class.new(2,2)
      pixel_matrix = Array.new(2) { Array.new(2) { "O" } }
      expect(bitmap.pixels).to eq(pixel_matrix)
    end
  end
end