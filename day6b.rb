#!/usr/bin/env ruby

def get_orbits(objects, object)
  orbits = []

  loop do
    object = objects[object]

    break if object == 'COM'

    orbits.push object
  end

  orbits
end

objects = {}

File.readlines(ARGV[0]).map { |x| x.strip.split(')') }.each do |a, b|
  objects[b] = a
end

orbits_you = get_orbits(objects, 'YOU')
orbits_san = get_orbits(objects, 'SAN').reverse

steps = 0
from = nil

orbits_you.each do |object|
  if orbits_san.include?(object)
    from = object
    break
  end

  steps += 1
end

p orbits_san.length - orbits_san.index(from) + steps - 1
