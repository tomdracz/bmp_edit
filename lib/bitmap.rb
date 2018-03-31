require_relative "./errors"

class Bitmap
  MIN_WIDTH = MIN_HEIGHT = 1
  MAX_WIDTH = MAX_HEIGHT = 250

  attr_reader :width, :height, :pixels

  def initialize(width, height)
    @width = width
    @height = height

    unless @width.is_a?(Integer) && @width.between?(1, MAX_WIDTH)
      raise InvalidWidthError, "width must be an integer between #{MIN_WIDTH} and #{MAX_WIDTH}"
    end

    unless @height.is_a?(Integer) && @height.between?(1, MAX_HEIGHT)
      raise InvalidHeightError, "height must be an integer between #{MIN_HEIGHT} and #{MAX_HEIGHT}"
    end

    @pixels = build_pixels
  end

  def clear_pixels
    @pixels = build_pixels
  end

  def set_pixel_colour(row, column, colour)
    unless row.is_a?(Integer) && row.between?(MIN_WIDTH, @width)
      raise PixelOutOfBoundsError, "row specified must be between 1 and #{@width}"
    end

    unless column.is_a?(Integer) && column.between?(MIN_HEIGHT, @width)
      raise PixelOutOfBoundsError, "column specified must be between 1 and #{@height}"
    end

    unless colour.is_a?(String) && /^[A-Z]$/.match(colour)
      raise InvalidColourError, "colour must be specified by a single capital letter"
    end

    @pixels[row-1][column-1] = colour
  end

  def draw_vertical_line(column, row_start, row_end, colour)
  end

  def draw_horizontal_line(row, column_start, column_end, colour)
  end

  def print_bitmap
  end

  private

  def build_pixels
    Array.new(@width) { Array.new(@height) { "O" } }
  end
end
