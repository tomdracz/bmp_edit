require_relative "../bitmap"

module Commands
  class Command
    def execute
      raise NotImplementedError, "execute method must be implemented"
    end

    private

    def no_bitmap_error
      raise NoBitmapError, "no bitmap created yet"
    end
  end
end
