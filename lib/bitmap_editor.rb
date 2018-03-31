require_relative "./bitmap"

class BitmapEditor
  attr_reader :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      parse_input(line.chomp)
    end
  end

  def parse_input(input_line)
    case input_line
    when /^I (\d+) (\d+)$/
      create_bitmap(Regexp.last_match(1), Regexp.last_match(2))
    when "C"
    when /^L (\d+) (\d+) ([A-Z])$/
    when /^V (\d+) (\d+) (\d+) ([A-Z])$/
    when /^H (\d+) (\d+) (\d+) ([A-Z])$/
    when "S"
      puts "There is no image"
    else
      puts 'unrecognised command :('
    end
  end

  private

  def create_bitmap(width, height)
    @bitmap = Bitmap.new(width: width.to_i, height: height.to_i)
  end
end
