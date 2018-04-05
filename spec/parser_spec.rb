require_relative "../lib/parser"

describe Parser do
  subject { described_class.new(bitmap) }
  let(:bitmap) { double("bmp") }

  describe "#initialize" do
    it "accepts bitmap as an argument" do
      instance = described_class.new(bitmap)
      expect(instance.bitmap).to eq(bitmap)
    end
  end

  describe "#parse_input" do
    let(:command_double) { double("command_instance") }

    context "with I command" do
      let(:bitmap) { nil }

      it "returns an instance of CreateBitmap command" do
        expect(Commands::CreateBitmap).to receive(:new).and_return(command_double)
        expect(subject.parse_input("I 5 6")).to eq(command_double)
      end
    end

    context "with C command" do
      let(:command) { "C" }

      it "returns an instance of ClearPixels command" do
        expect(Commands::ClearPixels).to receive(:new).
          with(bitmap: bitmap).
            and_return(command_double)
        expect(subject.parse_input(command)).to eq(command_double)
      end
    end

    context "with L command" do
      let(:command) { "L 1 3 A" }

      it "returns an instance of ColourPixel command" do
        expect(Commands::ColourPixel).to receive(:new).
          with(bitmap: bitmap, x: 1, y: 3, colour: "A").
            and_return(command_double)
        expect(subject.parse_input(command)).to eq(command_double)
      end
    end

    context "with V command" do
      let(:command) { "V 2 3 6 W" }

      it "returns an instance of DrawVerticalLine command" do
        expect(Commands::DrawVerticalLine).to receive(:new).
          with(bitmap: bitmap, x: 2, y1: 3, y2: 6, colour: "W").
            and_return(command_double)
        expect(subject.parse_input(command)).to eq(command_double)
      end
    end

    context "with H command" do
      let(:command) { "H 3 5 2 Z" }

      it "returns an instance of DrawHorizontalLine command" do
        expect(Commands::DrawHorizontalLine).to receive(:new).
          with(bitmap: bitmap, x1: 3, x2: 5, y: 2, colour: "Z").
            and_return(command_double)
        expect(subject.parse_input(command)).to eq(command_double)
      end
    end

    context "with S command" do
      let(:command) { "S" }

      it "calls the command to output the contents of the current image" do
        expect(Commands::ShowBitmap).to receive(:new).
          with(bitmap: bitmap).
            and_return(command_double)
        expect(subject.parse_input(command)).to eq(command_double)
      end
    end

    context "with unrecognised command" do
      let(:command) { "foo" }

      it "returns an error message about unrecognised command" do
        expect { subject.parse_input(command) }.to raise_error(UnrecognisedCommandError)
      end
    end
  end
end
