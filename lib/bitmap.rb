require_relative "./errors"

class Bitmap
  MIN_WIDTH = MIN_HEIGHT = 1
  MAX_WIDTH = MAX_HEIGHT = 250

  attr_reader :width, :height, :pixels

  def initialize(width:, height:)
    @width = width
    @height = height

    unless width_valid?(width: @width)
      raise InvalidWidthError, "width must be an integer between #{MIN_WIDTH} and #{MAX_WIDTH}"
    end

    unless height_valid?(height: @height)
      raise InvalidHeightError, "height must be an integer between #{MIN_HEIGHT} and #{MAX_HEIGHT}"
    end

    @pixels = build_pixels
  end

  def clear_pixels
    @pixels = build_pixels
  end

  def set_pixel_colour(x:, y:, colour:)
    unless x_coordinate_valid?(x: x) && y_coordinate_valid?(y: y)
      raise InvalidCoordinateError, "x and y coordinates must be between #{MIN_WIDTH} to #{@width} and #{MIN_HEIGHT} to #{@height} respectively"
    end

    unless colour_valid?(colour: colour)
      raise InvalidColourError, "colour must be specified by a single capital letter"
    end

    @pixels[x-1][y-1] = colour
  end

  def draw_vertical_line(x:, y1:, y2:, colour:)
    unless vertical_line_coordinates_valid?(x: x, y1: y1, y2: y2)
      raise InvalidCoordinateError, "x and y coordinates must be between #{MIN_WIDTH} to #{@width} and #{MIN_HEIGHT} to #{@height} respectively"
    end

    unless colour_valid?(colour: colour)
      raise InvalidColourError, "colour must be specified by a single capital letter"
    end

    (y1..y2).each do |y|
      set_pixel_colour(x: x, y: y, colour: colour)
    end
  end

  def draw_horizontal_line(x1:, x2:, y:, colour:)
    unless horizontal_line_coordinates_valid?(x1: x1, x2: x2, y: y)
      raise InvalidCoordinateError, "x and y coordinates must be between #{MIN_WIDTH} to #{@width} and #{MIN_HEIGHT} to #{@height} respectively"
    end

    unless colour_valid?(colour: colour)
      raise InvalidColourError, "colour must be specified by a single capital letter"
    end

    (x1..x2).each do |x|
      set_pixel_colour(x: x, y: y, colour: colour)
    end
  end

  def print_bitmap
  end

  private

  def width_valid?(width:)
    width.is_a?(Integer) && width.between?(1, MAX_WIDTH)
  end

  def height_valid?(height:)
    height.is_a?(Integer) && height.between?(1, MAX_HEIGHT)
  end

  def x_coordinate_valid?(x:)
    x.is_a?(Integer) && x.between?(MIN_WIDTH, @width)
  end

  def y_coordinate_valid?(y:)
    y.is_a?(Integer) && y.between?(MIN_HEIGHT, @height)
  end

  def colour_valid?(colour:)
    colour.is_a?(String) && /^[A-Z]$/.match(colour)
  end

  def vertical_line_coordinates_valid?(x:, y1:, y2:)
    x_coordinate_valid?(x: x) &&
    y_coordinate_valid?(y: y1) &&
    y_coordinate_valid?(y: y2) &&
    y1 <= y2
  end

  def horizontal_line_coordinates_valid?(x1:, x2:, y:)
    x_coordinate_valid?(x: x1) &&
    x_coordinate_valid?(x: x2) &&
    y_coordinate_valid?(y: y) &&
    x1 <= x2
  end

  def build_pixels
    Array.new(@width) { Array.new(@height) { "O" } }
  end
end
