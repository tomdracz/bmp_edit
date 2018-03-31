require_relative "../lib/bitmap"

describe Bitmap do
  subject { described_class.new(width: 5, height: 4) }

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
      expect { subject.set_pixel_colour(x: 100, y: 3, colour: "Z") }.to raise_error(PixelOutOfBoundsError)
    end

    it "raises an error if height is out of bounds" do
      expect { subject.set_pixel_colour(x: 2, y: 100, colour: "Z") }.to raise_error(PixelOutOfBoundsError)
    end

    it "raises an error if colour is invalid" do
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: "foo") }.to raise_error(InvalidColourError)
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: nil) }.to raise_error(InvalidColourError)
      expect { subject.set_pixel_colour(x: 2, y: 2, colour: []) }.to raise_error(InvalidColourError)
    end
  end

  describe "#draw_vertical_line" do
    it "draws a vertical segment in column x between rows y1 and y2 specified" do
      subject.draw_vertical_line(x: 3, y1: 1, y2: 3, colour: "F")
      expect(subject.pixels[2][0]).to eq("F")
      expect(subject.pixels[2][1]).to eq("F")
      expect(subject.pixels[2][2]).to eq("F")
    end
  end

  describe "#draw_horizontal_line" do
    it "draws a horizontal segment in row y between columns y1 and y2 specified" do
      subject.draw_horizontal_line(x1: 2, x2: 5, y: 4, colour: "M")
      expect(subject.pixels[1][3]).to eq("M")
      expect(subject.pixels[2][3]).to eq("M")
      expect(subject.pixels[3][3]).to eq("M")
      expect(subject.pixels[4][3]).to eq("M")
    end
  end

  describe "#print_bitmap" do
    it "outputs the current bitmap"
  end
end
