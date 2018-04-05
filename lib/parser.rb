require "forwardable"
require_relative "./bitmap"

class Parser
  extend Forwardable

  def_delegator :Bitmap, :new, :create_bitmap
  def_delegators :@bitmap,
    :clear_pixels,
    :set_pixel_colour,
    :draw_vertical_line,
    :draw_horizontal_line,
    :print_bitmap

  attr_reader :bitmap

  def initialize(bitmap = nil)
    @bitmap = bitmap
  end

  def parse_input(input_line)
    case input_line
    when /^I (\d+) (\d+)$/
      @bitmap = create_bitmap(
        width: Regexp.last_match[1].to_i,
        height: Regexp.last_match(2).to_i
      )
    when "C"
      no_bitmap_error unless @bitmap

      clear_pixels
    when /^L (\d+) (\d+) ([A-Z])$/
      no_bitmap_error unless @bitmap

      set_pixel_colour(
        x: Regexp.last_match(1).to_i,
        y: Regexp.last_match(2).to_i,
        colour: Regexp.last_match(3)
      )
    when /^V (\d+) (\d+) (\d+) ([A-Z])$/
      no_bitmap_error unless @bitmap

      draw_vertical_line(
        x: Regexp.last_match(1).to_i,
        y1: Regexp.last_match(2).to_i,
        y2: Regexp.last_match(3).to_i,
        colour: Regexp.last_match(4)
      )
    when /^H (\d+) (\d+) (\d+) ([A-Z])$/
      no_bitmap_error unless @bitmap

      draw_horizontal_line(
        x1: Regexp.last_match(1).to_i,
        x2: Regexp.last_match(2).to_i,
        y: Regexp.last_match(3).to_i,
        colour: Regexp.last_match(4)
      )
    when "S"
      no_bitmap_error unless @bitmap

      print_bitmap
    else
      unrecognised_command_error
    end
    self
  end

  private

  def no_bitmap_error
    raise NoBitmapError, "no bitmap created yet"
  end

  def unrecognised_command_error
    raise UnrecognisedCommandError, "command not valid"
  end
end
