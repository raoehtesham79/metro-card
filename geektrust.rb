require_relative 'input_manager.rb'

def main
  if ARGV.length != 1
    raise "File path not entered"
  end

  file_path = ARGV[0]
  file = File.open(file_path, 'r')
  lines = file.readlines
  InputManager.manage(lines)
end

main
