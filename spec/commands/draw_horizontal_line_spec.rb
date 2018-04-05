require_relative "../../lib/commands/draw_horizontal_line"

describe Commands::DrawHorizontalLine do
  let(:subject) { described_class.new(bitmap: bitmap, x1: 1, x2: 2, y: 3, colour: "A") }
  let(:bitmap) { instance_double("bmp") }

  describe "#initialize" do
    it "accepts bitmap, x1, x2, y and colour as arguments" do
      expect(subject.bitmap).to eq(bitmap)
      expect(subject.x1).to eq(1)
      expect(subject.x2).to eq(2)
      expect(subject.y).to eq(3)
      expect(subject.colour).to eq("A")
    end
  end

  describe "#execute" do
    it "calls the draw horizontal line command on bitmap and returns it" do
      expect(bitmap).to receive(:draw_horizontal_line).
        with(x1: 1, x2: 2, y: 3, colour: "A").
          and_return(bitmap)
      expect(subject.execute).to eq(bitmap)
    end

    it_behaves_like "a method requiring bitmap"
  end
end
