require_relative 'robot'

class Simulator
  ALLOWED_COMMANDS = ['MOVE', 'LEFT', 'RIGHT', 'REPORT']
  TABLE_MIN = 0
  TABLE_MAX = 5
  PLACE_COMMAND_REGEX = /PLACE ([#{TABLE_MIN}-#{TABLE_MAX}]),([#{TABLE_MIN}-#{TABLE_MAX}]),(EAST|WEST|NORTH|SOUTH)/

  attr_accessor :robot, :command, :read_from_file, :file_name

  def initialize
    self.robot = Robot.new
    self.file_name = ARGV[0]
    self.read_from_file = true if file_name
  end

  def run
    return run_by_user_input unless read_from_file
    run_by_from_file
  end

  def run_by_user_input
    execute while self.command = STDIN.gets.chomp
  end

  def run_by_from_file
    file = File.readlines(file_name)
    file.each { |command| self.command = command.strip; execute }
  rescue Errno::ENOENT
    puts "#{file_name} does not exist!"
  end

  def execute
    if matches = is_place_command?
      x, y, facing = matches[1], matches[2], matches[3]
      place_robot(x, y, facing)
    end

    robot.send(command.downcase.to_sym) if allowed_to_move?
  end

  def allowed_to_move?
    is_allowed_command? && robot.placed_once
  end

  def is_allowed_command?
    ALLOWED_COMMANDS.include?(command)
  end

  def is_place_command?
    PLACE_COMMAND_REGEX.match(command)
  end

  def place_robot(x, y, facing)
    robot.place(x, y, facing)
  end
end

