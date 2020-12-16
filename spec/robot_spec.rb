require 'spec_helper'
 
describe Robot do
  before(:each) do
    @robot = Robot.new
  end

  describe '#new' do
    it 'should create robot instance with blank position ojbect' do
      expect(@robot.position).not_to be_nil
      expect(@robot.placed_once).to be_falsy
    end
  end

  describe '#report' do
    it 'should return current position and direction of robot' do
      @robot.place(3,4,'SOUTH')
      expect { @robot.report }.to output("3,4,SOUTH\n").to_stdout
    end
  end

  describe '#place' do
    it 'should place robot position as specified' do
      @robot.place(2,3,'WEST')
      expect { @robot.report }.to output("2,3,WEST\n").to_stdout
    end
  end
end
