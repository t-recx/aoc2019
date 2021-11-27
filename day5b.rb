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

    if [1, 2, 7, 8].include? opcode
      p1 = program[instruction_pointer += 1]
      p2 = program[instruction_pointer += 1]

      output_position = program[instruction_pointer += 1]

      p1_value = get_value(program, p1, p1_mode)
      p2_value = get_value(program, p2, p2_mode)

      if [1, 2].include? opcode
        program[output_position] = [p1_value, p2_value].reduce(&(opcode == 1 ? :+ : :*))
      elsif opcode == 7
        program[output_position] = p1_value < p2_value ? 1 : 0
      elsif opcode == 8
        program[output_position] = p1_value == p2_value ? 1 : 0
      end
    elsif [3, 4].include? opcode
      position = program[instruction_pointer += 1]

      program[position] = input if opcode == 3
      puts program[position] if opcode == 4
    elsif [5, 6].include? opcode
      p1 = program[instruction_pointer += 1]
      p2 = program[instruction_pointer += 1]

      p1_value = get_value(program, p1, p1_mode)
      p2_value = get_value(program, p2, p2_mode)

      if opcode == 5 && p1_value != 0 || opcode == 6 && p1_value.zero?
        instruction_pointer = p2_value

        next
      end
    end

    instruction_pointer += 1
  end
end

program = File.read(ARGV[0]).split(',').map(&:to_i)

execute(program, 5)
