require_relative "command"

module Commands
  class ClearPixels < Command
    attr_reader :bitmap

    def initialize(bitmap:)
      @bitmap = bitmap
    end

    def execute
      no_bitmap_error unless @bitmap
      @bitmap.clear_pixels
      @bitmap
    end
  end
end
