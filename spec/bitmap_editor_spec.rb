require_relative "../lib/bitmap_editor"

describe BitmapEditor do
  let(:bitmap) { Bitmap.new(width: 5, height: 6) }
  subject { described_class.new(bitmap) }

  describe "#parse_input" do
    context "with I command" do
      it "creates bitmap of specified width and height" do
        subject.bitmap = nil
        expect(subject).to receive(:create_bitmap).with("5", "6").and_call_original
        subject.parse_input("I 5 6")
        expect(subject.bitmap.width).not_to be_nil
        expect(subject.bitmap.width).to eq(5)
        expect(subject.bitmap.height).to eq(6)
      end
    end

    context "with C command" do
      let(:command) { "C" }
      it "calls the command to clear bitmap to its initial state" do
        expect(subject).to receive(:clear_bitmap).and_call_original
        subject.parse_input(command)
      end
      it "returns an error if there is no bitmap" do
        subject.bitmap = nil
        expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
      end
    end

    context "with L command" do
      let(:command) { "L 1 3 A"}
      it "calls the command to colour the pixel at specified coordinates" do
        expect(subject).to receive(:colour_pixel).and_call_original
        subject.parse_input(command)
      end
      it "returns an error if there is no bitmap" do
        subject.bitmap = nil
        expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
      end
    end

    context "with V command" do
      let(:command) { "V 2 3 6 W"}
      it "calls the command to draw a vertical line of specified colour between given coordinates" do
        expect(subject).to receive(:vertical_line).with("2", "3", "6", "W").and_call_original
        subject.parse_input(command)
      end
      it "returns an error if there is no bitmap" do
        subject.bitmap = nil
        expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
      end
    end

    context "with H command" do
      let(:command) { "H 3 5 2 Z"}
      it "calls the command to draw a vertical line of specified colour between given coordinates" do
        expect(subject).to receive(:horizontal_line).with("3", "5", "2", "Z").and_call_original
        subject.parse_input(command)
      end
      it "returns an error if there is no bitmap" do
        subject.bitmap = nil
        expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
      end
    end

    context "with S command" do
      let(:command) { "S"}
      it "calls the command to output the contents of the current image" do
        expect(subject).to receive(:show_bitmap).and_call_original
        subject.parse_input(command)
      end
      it "returns an error if there is no bitmap" do
        subject.bitmap = nil
        expect { subject.parse_input(command) }.to raise_error(NoBitmapError)
      end
    end

    context "with unrecognised command" do
      let(:command) { "foo"}
      it "returns an error message about unrecognised command" do
        expect { subject.parse_input(command) }.to raise_error(UnrecognisedCommandError)
      end
    end
  end
end
