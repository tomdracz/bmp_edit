require_relative "../lib/bitmap_editor"

describe BitmapEditor do
  subject { described_class.new(bitmap) }
  let(:bitmap) { double("bmp") }

  describe "#parse_input" do
    context "with I command" do
      let(:bitmap) { nil }

      it "creates bitmap of specified width and height" do
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
        expect(subject).to receive(:clear_bitmap)
        subject.parse_input(command)
      end

      it "routes the clear call to bitmap" do
        expect(bitmap).to receive(:clear_pixels)
        subject.parse_input(command)
      end

      it_should_behave_like "a method requiring bitmap"
    end

    context "with L command" do
      let(:command) { "L 1 3 A" }

      it "calls the command to colour the pixel at specified coordinates" do
        expect(subject).to receive(:colour_pixel)
        subject.parse_input(command)
      end

      it "routes the colour pixel call to bitmap" do
        expect(bitmap).to receive(:set_pixel_colour).with(x: 1, y: 3, colour: "A")
        subject.parse_input(command)
      end

      it_should_behave_like "a method requiring bitmap"
    end

    context "with V command" do
      let(:command) { "V 2 3 6 W" }

      it "calls the command to draw a vertical line of specified colour between given coordinates" do
        expect(subject).to receive(:vertical_line).with("2", "3", "6", "W")
        subject.parse_input(command)
      end

      it "routes the draw vertical line call to bitmap" do
        expect(bitmap).to receive(:draw_vertical_line).with(x: 2, y1: 3, y2: 6, colour: "W")
        subject.parse_input(command)
      end

      it_should_behave_like "a method requiring bitmap"
    end

    context "with H command" do
      let(:command) { "H 3 5 2 Z" }

      it "calls the command to draw a vertical line of specified colour between given coordinates" do
        expect(subject).to receive(:horizontal_line).with("3", "5", "2", "Z")
        subject.parse_input(command)
      end

      it "routes the draw horizontal line call to bitmap" do
        expect(bitmap).to receive(:draw_horizontal_line).with(x1: 3, x2: 5, y: 2, colour: "Z")
        subject.parse_input(command)
      end

      it_should_behave_like "a method requiring bitmap"
    end

    context "with S command" do
      let(:command) { "S" }

      it "calls the command to output the contents of the current image" do
        expect(subject).to receive(:show_bitmap)
        subject.parse_input(command)
      end

      it "routes the command to print the image to bitmap" do
        expect(bitmap).to receive(:print_bitmap)
        subject.parse_input(command)
      end

      it_should_behave_like "a method requiring bitmap"
    end

    context "with unrecognised command" do
      let(:command) { "foo" }

      it "returns an error message about unrecognised command" do
        expect { subject.parse_input(command) }.to raise_error(UnrecognisedCommandError)
      end
    end
  end
end
