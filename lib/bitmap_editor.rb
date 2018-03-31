require_relative "./bitmap"

class BitmapEditor
  attr_reader :bitmap

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      parse_input(line.chomp)
    end
  end

  def parse_input(input_line)
    case line
    when 'S'
      puts "There is no image"
    else
      puts 'unrecognised command :('
    end
  end
end
