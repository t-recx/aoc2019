#!/usr/bin/env ruby

def calc_fuel(mass)
  fuel = (mass.to_i / 3).floor - 2

  return calc_fuel(fuel) + fuel if fuel.positive?

  0
end

puts File
  .readlines(ARGV[0])
  .map { |x| calc_fuel(x) }
  .sum
