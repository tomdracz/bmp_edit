require_relative "./errors"

class Bitmap
  MIN_WIDTH = MIN_HEIGHT = 1
  MAX_WIDTH = MAX_HEIGHT = 250

  attr_reader :width, :height, :pixels

  def initialize(width:, height:)
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

  def set_pixel_colour(x:, y:, colour:)
    unless x.is_a?(Integer) && x.between?(MIN_WIDTH, @width)
      raise PixelOutOfBoundsError, "x coordinate specified must be between 1 and #{@width}"
    end

    unless y.is_a?(Integer) && y.between?(MIN_HEIGHT, @height)
      raise PixelOutOfBoundsError, "y coordinate specified must be between 1 and #{@height}"
    end

    unless colour.is_a?(String) && /^[A-Z]$/.match(colour)
      raise InvalidColourError, "colour must be specified by a single capital letter"
    end

    @pixels[x-1][y-1] = colour
  end

  def draw_vertical_line(x:, y1:, y2:, colour:)
    (y1..y2).each do |y|
      set_pixel_colour(x: x, y: y, colour: colour)
    end
  end

  def draw_horizontal_line(x1:, x2:, y:, colour:)
    (x1..x2).each do |x|
      set_pixel_colour(x: x, y: y, colour: colour)
    end
  end

  def print_bitmap
  end

  private

  def build_pixels
    Array.new(@width) { Array.new(@height) { "O" } }
  end
end
