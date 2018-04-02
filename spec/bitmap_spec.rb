require_relative "../lib/bitmap"

describe Bitmap do
  subject { described_class.new(width: 5, height: 4) }
  let(:initial_pixels) { Array.new(5) { Array.new(4) { "O" } } }

  describe "#initialize" do
    context "with valid arguments" do
      it "sets width and height of bitmap" do
        bitmap = described_class.new(width: 2, height: 2)
        expect(bitmap.width).to eq(2)
        expect(bitmap.height).to eq(2)
      end

      it "sets the pixels matrix" do
        bitmap = described_class.new(width: 3, height: 5)
        pixel_matrix = Array.new(3) { Array.new(5) { "O" } }
        expect(bitmap.pixels).to eq(pixel_matrix)
      end
    end

    context "with invalid arguments" do
      it "raises an error if width is out of min and max range" do
        expect { described_class.new(width: 0, height: 134) }.to raise_error(InvalidWidthError)
        expect { described_class.new(width: 251, height: 134) }.to raise_error(InvalidWidthError)
        expect { described_class.new(width: -100, height: 134) }.to raise_error(InvalidWidthError)
      end

      it "raises an error if height is out of min and max range" do
        expect { described_class.new(width: 134, height: 0) }.to raise_error(InvalidHeightError)
        expect { described_class.new(width: 120, height: 278) }.to raise_error(InvalidHeightError)
        expect { described_class.new(width: 120, height: -5) }.to raise_error(InvalidHeightError)
      end

      it "raises an error if width is not an integer" do
        expect { described_class.new(width: "abc", height: 0) }.to raise_error(InvalidWidthError)
        expect { described_class.new(width: nil, height: 278) }.to raise_error(InvalidWidthError)
        expect { described_class.new(width: [], height: -5) }.to raise_error(InvalidWidthError)
      end

      it "raises an error if height is not an integer" do
        expect { described_class.new(width: 134, height: "foo") }.to raise_error(InvalidHeightError)
        expect { described_class.new(width: 120, height: []) }.to raise_error(InvalidHeightError)
        expect { described_class.new(width: 120, height: nil) }.to raise_error(InvalidHeightError)
      end
    end
  end

  describe "#clear_pixels" do
    it "sets all pixels to 'O' " do
      pixel_matrix = Array.new(subject.width) { Array.new(subject.height) { "O" } }
      subject.pixels[1][2] = "R"
      expect(subject.pixels).not_to eq(pixel_matrix)
      subject.clear_pixels
      expect(subject.pixels).to eq(pixel_matrix)
    end
  end

  describe "#set_pixel_colour" do
    it "sets the colour of the pixel at specified coordinates" do
      subject.set_pixel_colour(x: 2, y: 3, colour: "B")
      expect(subject.pixels[1][2]).to eq("B")
    end

    it "raises an error if width is out of bounds" do
      expect { subject.set_pixel_colour(x: 100, y: 3, colour: "Z") }.to raise_error(InvalidCoordinatesError)
    end

    it "raises an error if height is out of bounds" do
      expect { subject.set_pixel_colour(x: 2, y: 100, colour: "Z") }.to raise_error(InvalidCoordinatesError)
    end

    it "raises an error if colour is invalid" do
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: "foo") }.to raise_error(InvalidColourError)
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: nil) }.to raise_error(InvalidColourError)
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: []) }.to raise_error(InvalidColourError)
    end
  end

  describe "#draw_vertical_line" do
    context "with valid coordinates" do
      it "draws a vertical segment in column x between rows y1 and y2 specified" do
        subject.draw_vertical_line(x: 3, y1: 1, y2: 3, colour: "F")
        expect(subject.pixels[2][0]).to eq("F")
        expect(subject.pixels[2][1]).to eq("F")
        expect(subject.pixels[2][2]).to eq("F")
      end
    end

    context "with invalid coordinates" do
      it "raises an error if specified coordinates are out of bounds" do
        expect do
          subject.draw_vertical_line(x: subject.width, y1: 1, y2: subject.height + 1, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
      end

      it "raises an error if coordinates are in the wrong order" do
        expect do
          subject.draw_vertical_line(x: 2, y1: 3, y2: 1, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
      end

      it "does not change the pixel colours" do
        expect do
          subject.draw_vertical_line(x: 2, y1: 3, y2: subject.height + 1, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
        expect(subject.pixels).to eq(initial_pixels)
      end
    end
  end

  describe "#draw_horizontal_line" do
    context "with valid coordinates" do
      it "draws a horizontal segment in row y between columns y1 and y2 specified" do
        subject.draw_horizontal_line(x1: 2, x2: 5, y: 4, colour: "M")
        expect(subject.pixels[1][3]).to eq("M")
        expect(subject.pixels[2][3]).to eq("M")
        expect(subject.pixels[3][3]).to eq("M")
        expect(subject.pixels[4][3]).to eq("M")
      end
    end

    context "with invalid coordinates" do
      it "raises an error if specified coordinates are out of bounds" do
        expect do
          subject.draw_horizontal_line(x1: 1, x2: subject.width + 1, y: subject.height, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
      end

      it "raises an error if coordinates are in the wrong order" do
        expect do
          subject.draw_horizontal_line(x1: 3, x2: 1, y: 1, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
      end

      it "does not change the pixel colours" do
        expect do
          subject.draw_horizontal_line(x1: 1, x2: subject.width + 1, y: subject.height, colour: "F")
        end.to raise_error(InvalidCoordinatesError)
        expect(subject.pixels).to eq(initial_pixels)
      end
    end
  end

  describe "#print_bitmap" do
    it "outputs the current bitmap"
  end
end
