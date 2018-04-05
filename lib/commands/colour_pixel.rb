require_relative "command"

module Commands
  class ColourPixel < Command
    attr_reader :bitmap, :x, :y, :colour

    def initialize(bitmap:, x:, y:, colour:)
      @bitmap = bitmap
      @x = x
      @y = y
      @colour = colour
    end

    def execute
      no_bitmap_error unless @bitmap
      @bitmap.set_pixel_colour(x: @x, y: @y, colour: @colour)
      @bitmap
    end
  end
end
