#!/usr/bin/env ruby

def count_orbits(objects, object)
  count = 0

  loop do
    object = objects[object]
    count += 1

    break if object == 'COM'
  end

  count
end

objects = {}

File.readlines(ARGV[0]).map { |x| x.strip.split(')') }.each do |a, b|
  objects[b] = a
end

p objects
  .map { |object, _| count_orbits(objects, object) }
  .sum
