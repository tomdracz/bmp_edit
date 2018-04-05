require_relative "../../lib/commands/draw_vertical_line"

describe Commands::DrawVerticalLine do
  let(:subject) { described_class.new(bitmap: bitmap, x: 1, y1: 2, y2: 3, colour: "A") }
  let(:bitmap) { instance_double("bmp") }

  describe "#initialize" do
    it "accepts bitmap, x1, x2, y and colour as arguments" do
      expect(subject.bitmap).to eq(bitmap)
      expect(subject.x).to eq(1)
      expect(subject.y1).to eq(2)
      expect(subject.y2).to eq(3)
      expect(subject.colour).to eq("A")
    end
  end

  describe "#execute" do
    it "calls the draw vertical line command on bitmap and returns it" do
      expect(bitmap).to receive(:draw_vertical_line).
        with(x: 1, y1: 2, y2: 3, colour: "A").
          and_return(bitmap)
      expect(subject.execute).to eq(bitmap)
    end

    it_behaves_like "a method requiring bitmap"
  end
end
