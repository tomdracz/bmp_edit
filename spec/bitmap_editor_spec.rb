require_relative "../lib/bitmap_editor"

describe BitmapEditor do
  subject { described_class.new }

  describe "#initialize" do
    let(:bitmap) { double("bmp") }

    it "accepts bitmap as an argument" do
      instance = described_class.new(bitmap)
      expect(instance.bitmap).to eq(bitmap)
    end
  end

  describe "#run" do
    context "without input file supplied" do
      it "print an error message to stdout" do
        expect { subject.run(nil) }.to output(/Please provide correct file/).to_stdout
      end
    end

    context "with invalid file path supplied" do
      it "print an error message to stdout" do
        allow(File).to receive(:exist?).and_return(false)
        expect { subject.run("FOO") }.to output(/Please provide correct file/).to_stdout
      end
    end

    context "with correct file" do
      let(:parser_double) { instance_double("Parser", bitmap: "foo") }
      let(:test_command) { "I 25 25" }

      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(File).to receive(:open).and_return([test_command])
      end

      it "passes the command to parser instance" do
        allow(Parser).to receive(:new).and_return(parser_double)
        allow(parser_double).to receive(:parse_input).and_return(parser_double)

        subject.run("FOO")
        expect(parser_double).to have_received(:parse_input).with(test_command)
      end

      it "prints the error if exception occur" do
        allow(Parser).to receive(:new).and_raise(BitmapEditorError)
        expect { subject.run("FOO") }.to output(/Error on line number/).to_stdout
      end

      it "does not rescue unkown exceptions" do
        allow(Parser).to receive(:new).and_raise(StandardError)
        expect { subject.run("FOO") }.to raise_error(StandardError)
      end
    end
  end
end
