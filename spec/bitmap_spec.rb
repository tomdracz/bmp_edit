require_relative '../lib/bitmap'

describe Bitmap do
  describe "#initialize" do
    subject { described_class.new(5,4) }

    context "with valid arguments" do
      it "sets width and height of bitmap" do
        bitmap = described_class.new(2,2)
        expect(bitmap.width).to eq(2)
        expect(bitmap.height).to eq(2)
      end

      it "sets the pixels matrix" do
        bitmap = described_class.new(3,5)
        pixel_matrix = Array.new(3) { Array.new(5) { "O" } }
        expect(bitmap.pixels).to eq(pixel_matrix)
      end
    end

    context "with invalid arguments" do
      it "raises an error if width is out of min and max range" do
        expect { described_class.new(0,134) }.to raise_error(InvalidWidthError)
        expect { described_class.new(251,134) }.to raise_error(InvalidWidthError)
        expect { described_class.new(-100,134) }.to raise_error(InvalidWidthError)
      end

      it "raises an error if height is out of min and max range" do
        expect { described_class.new(134,0) }.to raise_error(InvalidHeightError)
        expect { described_class.new(120,278) }.to raise_error(InvalidHeightError)
        expect { described_class.new(120,-5) }.to raise_error(InvalidHeightError)
      end

      it "raises an error if width is not an integer" do
        expect { described_class.new("abc",0) }.to raise_error(InvalidWidthError)
        expect { described_class.new(nil,278) }.to raise_error(InvalidWidthError)
        expect { described_class.new([],-5) }.to raise_error(InvalidWidthError)
      end

      it "raises an error if height is not an integer" do
        expect { described_class.new(134,"foo") }.to raise_error(InvalidHeightError)
        expect { described_class.new(120,[]) }.to raise_error(InvalidHeightError)
        expect { described_class.new(120,nil) }.to raise_error(InvalidHeightError)
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
  end
end