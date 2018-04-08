require_relative "../../lib/commands/colour_pixel"

describe Commands::ColourPixel do
  let(:subject) { described_class.prepare(bitmap: bitmap, x: 1, y: 2, colour: "A") }
  let(:bitmap) { instance_double("bmp") }

  describe "#prepare" do
    it "accepts bitmap, x, y and colour as arguments" do
      expect(subject.bitmap).to eq(bitmap)
      expect(subject.x).to eq(1)
      expect(subject.y).to eq(2)
      expect(subject.colour).to eq("A")
    end
  end

  describe "#execute" do
    it "calls the set pixel colour command on bitmap and returns it" do
      expect(bitmap).to receive(:set_pixel_colour).
        with(x: 1, y: 2, colour: "A").
          and_return(bitmap)
      expect(subject.execute).to eq(bitmap)
    end

    it_behaves_like "a method requiring bitmap"
  end
end
