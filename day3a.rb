#!/usr/bin/env ruby

lines = File.readlines(ARGV[0])

directions = { R: [1, 0], L: [-1, 0], U: [0, -1], D: [0, 1] }
wires = []

lines.each do |line|
  x, y = 0, 0

  wire = {}

  line.split(',').map { |token| [token[0].to_sym, token[1..-1].to_i] }.each do |instruction, number|
    number.times do |n|
      x += directions[instruction][0]
      y += directions[instruction][1]

      wire[y] = {} if not wire[y]

      wire[y][x] = true
    end 
  end

  wires.push wire
end

first_wire = wires.first
second_wire = wires.last

crossings = []

first_wire.keys.each do |fy|
  if second_wire[fy] 
    first_wire[fy].keys.each do |fx|
      if second_wire[fy][fx]
        crossings.push [fy, fx]
      end
    end
  end
end

crossings.map { |x| p x }
