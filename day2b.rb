#!/usr/bin/env ruby

def execute(program, noun, verb)
  program[1] = noun
  program[2] = verb

  program.each_slice(4) do |opcode, p1, p2, output_position|
    return program[0] if opcode == 99

    program[output_position] = [program[p1], program[p2]].reduce(&(opcode == 1 ? :+ : :*))
  end
end

input = File.read(ARGV[0]).split(',').map(&:to_i)
desired_output = 19_690_720

(0..99).each do |noun|
  (0..99).each do |verb|
    return puts 100 * noun + verb if execute(input.clone, noun, verb) == desired_output
  end
end
