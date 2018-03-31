require_relative "../lib/bitmap_editor"

describe BitmapEditor do
  let(:bitmap) { Bitmap.new(5,6) }

  describe "#parse_input" do
    context "with I command" do
      it "creates bitmap of specified width and height" do
        expect(subject).to receive(:create_bitmap).with("5", "6").and_call_original
        subject.parse_input("I 5 6")
        expect(subject.bitmap).not_to be_nil
      end
    end

    context "with C command" do
      it "clears bitmap to its initial state"
      it "returns an error if there is not bitmap"
    end

    context "with L command" do
      it "colours the pixel at specified coordinates"
      it "returns an error if there is no bitmap"
    end

    context "with V command" do
      it "draws a vertical line of specified colour between given coordinates"
      it "returns an error if there is no bitmap"
    end

    context "with H command" do
      it "draws a vertical line of specified colour between given coordinates"
      it "returns an error if there is no bitmap"
    end

    context "with S command" do
      it "outputs the contents of the current image"
      it "returns an error if there is no bitmap"
    end

    context "with unrecognised command" do
      it "returns an error message about unrecognised command"
    end
  end
end
