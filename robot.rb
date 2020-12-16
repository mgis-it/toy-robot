require_relative 'position'

class Robot
  attr_accessor :position, :placed_once

  def initialize
    self.position = Position.new
    self.placed_once = false
  end

  def report
    puts "#{position.x},#{position.y},#{position.facing}"
  end

  def move
    position.move_forward
  end

  def left
    position.turn_left
  end

  def right
    position.turn_right
  end

  def place(x, y, facing)
    self.placed_once = true unless placed_once
    position.move_to(x, y, facing)
  end
end
