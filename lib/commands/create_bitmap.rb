require_relative "command"

module Commands
  class CreateBitmap < Command
    class << self
      attr_reader :width, :height, :bitmap

      def prepare(width:, height:)
        @width = width
        @height = height
        self
      end

      def execute
        @bitmap = Bitmap.new(width: @width, height: @height)
      end
    end
  end
end
