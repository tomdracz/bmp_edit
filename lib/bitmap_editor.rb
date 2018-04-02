require_relative "./bitmap"

class BitmapEditor
  attr_accessor :bitmap

  def initialize(bitmap=nil)
    @bitmap = bitmap
  end

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
      clear_bitmap
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

  def no_bitmap_error
    raise NoBitmapError, "no bitmap created yet"
  end

  def clear_bitmap
    no_bitmap_error unless @bitmap
    @bitmap.clear_pixels
  end

  def colour_pixel(x, y, colour)
    no_bitmap_error unless @bitmap
    @bitmap.set_pixel_colour(x: x, y: y, colour: colour)
  end

  def vertical_line(x, y1, y2, colour)
    no_bitmap_error unless @bitmap
    @bitmap.draw_vertical_line(x: x, y1: y1, y2: y2, colour: colour)
  end

  def horizontal_line(x1, x2, y, colour)
    no_bitmap_error unless @bitmap
    @bitmap.draw_horizontal_line(x1: x1, x2: x2, y: y, colour: colour)
  end

  def show_bitmap
    no_bitmap_error unless @bitmap
    @bitmap.print_bitmap
  end
end
