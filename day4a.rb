#!/usr/bin/env ruby

def is_valid? password
  previous = 0
  has_double_digits = false

  password.chars.map(&:to_i).each do |n|
    if previous == n
      has_double_digits = true
    end

    return false if n < previous

    previous = n
  end

  return has_double_digits
end

min, max = File.read(ARGV[0]).strip.split('-')

puts (min..max)
  .select { |password| is_valid?(password) }
  .count
