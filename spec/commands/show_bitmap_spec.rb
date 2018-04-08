require_relative "../../lib/commands/show_bitmap"

describe Commands::ShowBitmap do
  let(:subject) { described_class.prepare(bitmap: bitmap) }
  let(:bitmap) { instance_double("bmp") }

  describe "#prepare" do
    it "accepts bitmap as an argument" do
      expect(subject.bitmap).to eq(bitmap)
    end
  end

  describe "#execute" do
    it "calls the print bitmap on bitmap and returns it" do
      expect(bitmap).to receive(:print_bitmap).
        and_return(bitmap)
      expect(subject.execute).to eq(bitmap)
    end

    it_behaves_like "a method requiring bitmap"
  end
end
