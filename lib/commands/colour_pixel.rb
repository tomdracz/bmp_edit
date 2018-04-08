require_relative "command"

module Commands
  class ColourPixel < Command
    class << self
      attr_reader :bitmap, :x, :y, :colour

      def prepare(bitmap:, x:, y:, colour:)
        @bitmap = bitmap
        @x = x
        @y = y
        @colour = colour
        self
      end

      def execute
        no_bitmap_error unless @bitmap
        @bitmap.set_pixel_colour(x: @x, y: @y, colour: @colour)
        @bitmap
      end
    end
  end
end
