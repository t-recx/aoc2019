#!/usr/bin/env ruby

program = File.read(ARGV[0]).split(',').map(&:to_i)

program[1] = 12
program[2] = 2

program.each_slice(4) do |opcode, p1, p2, output_position|
  return puts(program[0]) if opcode == 99

  program[output_position] = [program[p1], program[p2]].reduce(&(opcode == 1 ? :+ : :*))
end
