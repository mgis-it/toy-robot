class Position
  DIRECTIONS = ['NORTH', 'WEST', 'SOUTH', 'EAST']

  attr_accessor :x, :y, :facing

  def turn_right
    self.facing = DIRECTIONS[current_index - 1]
  end

  def turn_left
    self.facing = facing == 'EAST' ? 'NORTH' : DIRECTIONS[current_index + 1]
  end

  def current_index
    DIRECTIONS.index(facing)
  end

  def move_forward
    return if going_to_fall?

    return self.y += 1 if facing == 'NORTH'
    return self.y -= 1 if facing == 'SOUTH'
    return self.x += 1 if facing == 'EAST'
    self.x -= 1 if facing == 'WEST'
  end

  def move_to(x, y, facing)
    self.x = x.to_i
    self.y = y.to_i
    self.facing = facing
  end

  def going_to_fall?
    (x == Simulator::TABLE_MAX && facing == 'EAST') ||
      (y == Simulator::TABLE_MAX && facing == 'NORTH') ||
      (x == Simulator::TABLE_MIN && facing == 'WEST') ||
      (y == Simulator::TABLE_MIN && facing == 'SOUTH')
  end
end
