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
      colour_pixel(Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3))
    when /^V (\d+) (\d+) (\d+) ([A-Z])$/
      vertical_line(Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3), Regexp.last_match(4))
    when /^H (\d+) (\d+) (\d+) ([A-Z])$/
      horizontal_line(Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3), Regexp.last_match(4))
    when "S"
      show_bitmap
    else
      unrecognised_command_error
    end
  end

  private

  def create_bitmap(width, height)
    @bitmap = Bitmap.new(width: width.to_i, height: height.to_i)
  end

  def no_bitmap_error
    raise NoBitmapError, "no bitmap created yet"
  end

  def unrecognised_command_error
    raise UnrecognisedCommandError, "command not valid"
  end

  def clear_bitmap
    no_bitmap_error unless @bitmap
    @bitmap.clear_pixels
  end

  def colour_pixel(x, y, colour)
    no_bitmap_error unless @bitmap
    @bitmap.set_pixel_colour(x: x.to_i, y: y.to_i, colour: colour)
  end

  def vertical_line(x, y1, y2, colour)
    no_bitmap_error unless @bitmap
    @bitmap.draw_vertical_line(x: x.to_i, y1: y1.to_i, y2: y2.to_i, colour: colour)
  end

  def horizontal_line(x1, x2, y, colour)
    no_bitmap_error unless @bitmap
    @bitmap.draw_horizontal_line(x1: x1.to_i, x2: x2.to_i, y: y.to_i, colour: colour)
  end

  def show_bitmap
    no_bitmap_error unless @bitmap
    @bitmap.print_bitmap
  end
end
