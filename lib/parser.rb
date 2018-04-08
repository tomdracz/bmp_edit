require_relative "./commands/command"
require_relative "./commands/create_bitmap"
require_relative "./commands/clear_pixels"
require_relative "./commands/colour_pixel"
require_relative "./commands/draw_horizontal_line"
require_relative "./commands/draw_vertical_line"
require_relative "./commands/show_bitmap"

class Parser
  attr_reader :bitmap

  def initialize(bitmap = nil)
    @bitmap = bitmap
  end

  def parse_input(input_line)
    case input_line
    when /^I (\d+) (\d+)$/
      Commands::CreateBitmap.prepare(
        width: Regexp.last_match[1].to_i,
        height: Regexp.last_match(2).to_i
      )
    when "C"
      Commands::ClearPixels.prepare(bitmap: @bitmap)
    when /^L (\d+) (\d+) ([A-Z])$/
      Commands::ColourPixel.prepare(
        bitmap: @bitmap,
        x: Regexp.last_match(1).to_i,
        y: Regexp.last_match(2).to_i,
        colour: Regexp.last_match(3)
      )
    when /^V (\d+) (\d+) (\d+) ([A-Z])$/
      Commands::DrawVerticalLine.prepare(
        bitmap: @bitmap,
        x: Regexp.last_match(1).to_i,
        y1: Regexp.last_match(2).to_i,
        y2: Regexp.last_match(3).to_i,
        colour: Regexp.last_match(4)
      )
    when /^H (\d+) (\d+) (\d+) ([A-Z])$/
      Commands::DrawHorizontalLine.prepare(
        bitmap: @bitmap,
        x1: Regexp.last_match(1).to_i,
        x2: Regexp.last_match(2).to_i,
        y: Regexp.last_match(3).to_i,
        colour: Regexp.last_match(4)
      )
    when "S"
      Commands::ShowBitmap.prepare(bitmap: @bitmap)
    else
      unrecognised_command_error
    end
  end

  private

  def unrecognised_command_error
    raise UnrecognisedCommandError, "command not valid"
  end
end
