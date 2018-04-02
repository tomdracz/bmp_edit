require_relative '../../lib/bitmap_editor'

describe 'parsing input file' do
  let(:bitmap_editor) { BitmapEditor.new }

  context 'parsing example command file' do
    let(:command_file) { File.expand_path("../../fixtures/example_image_commands.txt", __FILE__) }
    let(:result_file) { File.expand_path("../../fixtures/example_image_result.txt", __FILE__) }

    it "prints the expected bitmap to stdout" do
      expect do
        bitmap_editor.run(command_file)
      end.to output(File.read(result_file)).to_stdout
    end
  end

  context 'parsing a file with commands in incorrect order' do
    let(:command_file) { File.expand_path("../../fixtures/incorrect_order_commands_example.txt", __FILE__) }

    it "prints the relevant error message to stdout" do
      expect do
        bitmap_editor.run(command_file)
      end.to output(/no bitmap created yet/).to_stdout
    end
  end

  context 'calling editor without a file' do
    let(:command_file) { File.expand_path("../../fixtures/foobarbaz.txt", __FILE__) }

    it "prints the message about file missing to stdout" do
      expect do
        bitmap_editor.run(command_file)
      end.to output(/Please provide correct file/).to_stdout
    end
  end

  context 'using an unrecognised command' do
    let(:command_file) { File.expand_path("../../fixtures/unrecognised_commands_example.txt", __FILE__) }

    it "prints the expected bitmap to stdout" do
      expect do
        bitmap_editor.run(command_file)
      end.to output(/command not valid/).to_stdout
    end
  end
end