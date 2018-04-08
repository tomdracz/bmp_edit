require_relative "../../lib/commands/create_bitmap"

describe Commands::CreateBitmap do
  let(:subject) { described_class.prepare(width: 1, height: 2) }

  describe "#prepare" do
    it "accepts width and height as arguments" do
      expect(subject.width).to eq(1)
      expect(subject.height).to eq(2)
    end
  end

  describe "#execute" do
    it "returns a new bitmap of specified width and height" do
      expect(subject.execute).to be_a(Bitmap)
      expect(subject.execute.width).to eq(1)
      expect(subject.execute.height).to eq(2)
    end
  end
end
