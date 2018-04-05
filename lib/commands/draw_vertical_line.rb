require_relative "command"

module Commands
  class DrawVerticalLine < Command
    attr_reader :bitmap, :x, :y1, :y2, :colour

    def initialize(bitmap:, x:, y1:, y2:, colour:)
      @bitmap = bitmap
      @x = x
      @y1 = y1
      @y2 = y2
      @colour = colour
    end

    def execute
      no_bitmap_error unless @bitmap
      @bitmap.draw_vertical_line(x: @x, y1: @y1, y2: @y2, colour: @colour)
      @bitmap
    end
  end
end
