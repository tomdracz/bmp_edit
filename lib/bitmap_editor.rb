require_relative "./parser"

class BitmapEditor
  attr_reader :bitmap

  def initialize(bitmap = nil)
    @bitmap = bitmap
  end

  def run(file)
    return print "Please provide correct file" if file.nil? || !File.exist?(file)

    File.open(file).each_with_index do |line, line_number|
      begin
        parser = Parser.new(@bitmap)
        result = parser.parse_input(line.chomp)
        @bitmap = result.bitmap if result.bitmap
      rescue BitmapEditorError => e
        print "Error on line number #{line_number + 1}: #{e.message}\n"
        print "Command was \"#{line.chomp}\"\n"
      end
    end
  end
end
