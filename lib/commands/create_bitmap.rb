require_relative "command"

module Commands
  class CreateBitmap < Command
    attr_reader :width, :height, :bitmap

    def initialize(width:, height:)
      @width = width
      @height = height
    end

    def execute
      @bitmap = Bitmap.new(width: @width, height: @height)
    end
  end
end
