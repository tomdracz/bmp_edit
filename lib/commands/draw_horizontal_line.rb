require_relative "command"

module Commands
  class DrawHorizontalLine < Command
    attr_reader :bitmap, :x1, :x2, :y, :colour

    def initialize(bitmap:, x1:, x2:, y:, colour:)
      @bitmap = bitmap
      @x1 = x1
      @x2 = x2
      @y = y
      @colour = colour
    end

    def execute
      no_bitmap_error unless @bitmap
      @bitmap.draw_horizontal_line(x1: @x1, x2: @x2, y: @y, colour: @colour)
      @bitmap
    end
  end
end
