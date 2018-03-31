class InvalidWidthError < StandardError
end

class InvalidHeightError < StandardError
end


class Bitmap
  attr_reader :width, :height, :pixels

  def initialize(width, height)
    @width = width
    @height = height
    raise InvalidWidthError, "width must be an integer" unless @width.is_a?(Integer)
    raise InvalidHeightError, "height must be an integer" unless @height.is_a?(Integer)
    raise InvalidWidthError, "invalid width specified" unless @width.between?(1,250)
    raise InvalidHeightError, "invalid height specified" unless @height.between?(1,250)
    @pixels = build_pixels
  end

  private

  def build_pixels
    Array.new(@width) { Array.new(@height) { "O" } }
  end
end
