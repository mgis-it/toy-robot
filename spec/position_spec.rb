require 'spec_helper'
 
describe Position do
  before(:each) do
    @position = Position.new
    @position.move_to(3, 4, 'NORTH')
  end

  describe '#turn_right' do
    it 'should turn position direction to eash' do
      @position.turn_right
      expect(@position.facing).to eq('EAST')
    end
  end

  describe '#turn_left' do
    it 'should turn position direction to eash' do
      @position.turn_left
      expect(@position.facing).to eq('WEST')
    end
  end

  describe '#current_index' do
    it 'should return current index of facing in direction' do
      expect(@position.current_index).to eq(Position::DIRECTIONS.index('NORTH'))
    end
  end

  describe '#move_forward' do
    it 'should move position one step further in direction of facing' do
      @position.move_forward
      expect(@position.y).to eq(5)
      expect(@position.x).to eq(3)
      expect(@position.facing).to eq('NORTH')
    end

    it 'should not move position one step further if falling' do
      @position.move_to(5,5,'NORTH')
      @position.move_forward
      expect(@position.y).to eq(5)
      expect(@position.x).to eq(5)
      expect(@position.facing).to eq('NORTH')
    end
  end

  describe '#move_to' do
    it 'should move position' do
      @position.move_to(1,1,'EAST')
      expect(@position.y).to eq(1)
      expect(@position.x).to eq(1)
      expect(@position.facing).to eq('EAST')
    end
  end

  describe '#going_to_fall?' do
    it 'should return true if position exceeds table boundaries' do
      @position.move_to(5,5,'NORTH')
      expect(@position.going_to_fall?).to be_truthy
    end

    it 'should return false if position exceeds table boundaries' do
      @position.move_to(5,5,'SOUTH')
      expect(@position.going_to_fall?).to be_falsy
    end
  end
end
