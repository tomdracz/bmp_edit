class BitmapEditorError < StandardError
end

class InvalidWidthError < BitmapEditorError
end

class InvalidHeightError < BitmapEditorError
end

class InvalidCoordinateError < BitmapEditorError
end

class InvalidColourError < BitmapEditorError
end

class NoBitmapError < BitmapEditorError
end

class UnrecognisedCommandError < BitmapEditorError
end
