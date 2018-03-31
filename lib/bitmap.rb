class InvalidWidthError < StandardError
end

class InvalidHeightError < StandardError
end

class PixelOutOfBoundsError < StandardError
end

class InvalidColourError < StandardError
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

  def clear_pixels
    @pixels = build_pixels
  end

  def set_pixel_colour(row, column, colour)
    raise PixelOutOfBoundsError, "row specified must be between 1 and #{@width}" unless row.is_a?(Integer) && row.between?(1, @width)
    raise PixelOutOfBoundsError, "column specified must be between 1 and #{@height}" unless column.is_a?(Integer) && column.between?(1, @width)
    raise InvalidColourError, "colour must be specified by a single capital letter" unless colour.is_a?(String) && (/^[A-Z]$/).match(colour)

    @pixels[row-1][column-1] = colour
  end

  private

  def build_pixels
    Array.new(@width) { Array.new(@height) { "O" } }
  end
end
