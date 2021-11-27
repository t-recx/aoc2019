#!/usr/bin/env ruby

POSITION = 0
IMMEDIATE = 1

def get_value(program, parameter, mode)
  mode == POSITION ? program[parameter] : parameter
end

def execute(program, input)
  instruction_pointer = 0

  loop do
    instruction = program[instruction_pointer].to_s.rjust(4, '0')
    opcode = instruction[2..3].to_i
    p1_mode = instruction[1].to_i
    p2_mode = instruction[0].to_i

    break if opcode == 99

    if [1, 2].include? opcode
      p1 = program[instruction_pointer += 1]
      p2 = program[instruction_pointer += 1]

      output_position = program[instruction_pointer += 1]

      program[output_position] = [
        get_value(program, p1, p1_mode),
        get_value(program, p2, p2_mode)
      ]
      .reduce(&(opcode == 1 ? :+ : :*))
    elsif [3, 4].include? opcode
      position = program[instruction_pointer += 1]

      program[position] = input if opcode == 3
      puts program[position] if opcode == 4
    end

    instruction_pointer += 1
  end
end

program = File.read(ARGV[0]).split(',').map(&:to_i)

execute(program, 1)
