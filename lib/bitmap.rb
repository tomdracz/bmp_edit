class Bitmap
  attr_reader :width, :height, :pixels

  def initialize(width, height)
    @width = width
    @height = height
    @pixels = build_pixels
  end

  private

  def build_pixels
    []
  end
end
