require_relative "command"

module Commands
  class ShowBitmap < Command
    class << self
      attr_reader :bitmap

      def prepare(bitmap:)
        @bitmap = bitmap
        self
      end

      def execute
        no_bitmap_error unless @bitmap
        @bitmap.print_bitmap
        @bitmap
      end
    end
  end
end
