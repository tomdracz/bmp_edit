require_relative "command"

module Commands
  class ClearPixels < Command
    class << self
      attr_reader :bitmap

      def prepare(bitmap:)
        @bitmap = bitmap
        self
      end

      def execute
        no_bitmap_error unless @bitmap
        @bitmap.clear_pixels
        @bitmap
      end
    end
  end
end
