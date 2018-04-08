require_relative "command"

module Commands
  class DrawVerticalLine < Command
    class << self
      attr_reader :bitmap, :x, :y1, :y2, :colour

      def prepare(bitmap:, x:, y1:, y2:, colour:)
        @bitmap = bitmap
        @x = x
        @y1 = y1
        @y2 = y2
        @colour = colour
        self
      end

      def execute
        no_bitmap_error unless @bitmap
        @bitmap.draw_vertical_line(x: @x, y1: @y1, y2: @y2, colour: @colour)
        @bitmap
      end
    end
  end
end
