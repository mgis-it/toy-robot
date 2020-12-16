require 'spec_helper'
 
describe Simulator do
  before(:each) do
    @simulator = Simulator.new
  end

  describe '#new' do
    it 'should create instance of simulator object' do
      expect(@simulator.robot).not_to be_nil
    end
  end

  describe '#run' do
    it 'should run simulator with reading from file with all valid commands' do
      @simulator.file_name = File.expand_path(File.dirname(__FILE__) + '/test.txt')
      @simulator.read_from_file = true
      expect { @simulator.run }.to output("3,3,NORTH\n").to_stdout
    end

    it 'should run simulator with reading from file with valid and invalid commands' do
      @simulator.file_name = File.expand_path(File.dirname(__FILE__) + '/corrupted_test.txt')
      @simulator.read_from_file = true
      expect { @simulator.run }.to output("3,5,NORTH\n").to_stdout
    end

    it 'should run simulator with reading from file with valid and invalid commands' do
      @simulator.file_name = File.expand_path(File.dirname(__FILE__) + '/notfoundfile.txt')
      @simulator.read_from_file = true
      expect { @simulator.run }.to output("#{@simulator.file_name} does not exist!\n").to_stdout
    end

    it 'should run simulator with user input' do
      commands = ['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE']

      commands.each do |command|
        @simulator.command = command
        @simulator.execute
      end

      @simulator.command = 'REPORT'
      expect { @simulator.execute }.to output("3,3,NORTH\n").to_stdout
    end

    it 'should run simulator with user input with valid and invalid commands' do
      commands = ['PLACE 6,7,EAST', 'PLACE 3,4,NORTH', 'MOVE', 'MOVE']

      commands.each do |command|
        @simulator.command = command
        @simulator.execute
      end

      @simulator.command = 'REPORT'
      expect { @simulator.execute }.to output("3,5,NORTH\n").to_stdout
    end
  end

  describe '#execute?' do
    before(:each) do
      @simulator.place_robot(1,2,'WEST')
    end
    it 'should execute move command' do
      @simulator.command = 'MOVE'
      @simulator.execute
      expect { @simulator.robot.report }.to output("0,2,WEST\n").to_stdout
    end

    it 'should execute left command' do
      @simulator.command = 'LEFT'
      @simulator.execute
      expect { @simulator.robot.report }.to output("1,2,SOUTH\n").to_stdout
    end

    it 'should execute right command' do
      @simulator.command = 'RIGHT'
      @simulator.execute
      expect { @simulator.robot.report }.to output("1,2,NORTH\n").to_stdout
    end

    it 'should execute valid place command' do
      @simulator.command = 'PLACE 3,4,EAST'
      @simulator.execute
      expect { @simulator.robot.report }.to output("3,4,EAST\n").to_stdout
    end

    it 'should not execute invalid place command' do
      @simulator.command = 'PLACE 6,7,EAST'
      @simulator.execute
      expect { @simulator.robot.report }.to output("1,2,WEST\n").to_stdout
    end

    it 'should not execute valid command before valid place command' do
      simulator = Simulator.new
      simulator.command = 'MOVE'
      simulator.execute
      expect(simulator.robot.position.x).to eql(nil)
      expect(simulator.robot.position.y).to eql(nil)
    end
  end

  describe '#allowed_to_move?' do
    it 'should return true if command is allowed and robot is placed' do
      @simulator.place_robot(1,2,'WEST')
      @simulator.command = 'MOVE'

      expect(@simulator.allowed_to_move?).to be_truthy
    end

    it 'should return false if command is allowed but robot is not placed' do
      @simulator.command = 'MOVE'
      expect(@simulator.allowed_to_move?).to be_falsy
    end
  end

  describe '#is_allowed_command?' do
    it 'should return true if command is valid' do
      @simulator.command = 'MOVE'
      expect(@simulator.is_allowed_command?).to be_truthy
    end

    it 'should not return true if there is invalid command' do
      @simulator.command = 'INVALID'
      expect(@simulator.is_allowed_command?).to be_falsy
    end
  end

  describe '#is_place_command?' do
    it 'should return matches if there is valid place command' do
      @simulator.command = 'PLACE 2,5,WEST'
      expect(@simulator.is_place_command?).not_to be_nil
    end

    it 'should return nil if there is invalid place command' do
      @simulator.command = 'PLACE ALTERNATIVE,2,5,WEST'
      expect(@simulator.is_place_command?).to be_nil
    end
  end
end
