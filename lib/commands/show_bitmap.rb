require_relative "command"

module Commands
  class ShowBitmap < Command
    attr_reader :bitmap

    def initialize(bitmap:)
      @bitmap = bitmap
    end

    def execute
      no_bitmap_error unless @bitmap
      @bitmap.print_bitmap
      @bitmap
    end
  end
end
