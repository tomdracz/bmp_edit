require_relative "command"

module Commands
  class DrawHorizontalLine < Command
    class << self
      attr_reader :bitmap, :x1, :x2, :y, :colour

      def prepare(bitmap:, x1:, x2:, y:, colour:)
        @bitmap = bitmap
        @x1 = x1
        @x2 = x2
        @y = y
        @colour = colour
        self
      end

      def execute
        no_bitmap_error unless @bitmap
        @bitmap.draw_horizontal_line(x1: @x1, x2: @x2, y: @y, colour: @colour)
        @bitmap
      end
    end
  end
end
