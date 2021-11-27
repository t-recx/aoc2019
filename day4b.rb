#!/usr/bin/env ruby

def is_valid? password
  previous = 0
  check_double_digits = {}

  password.chars.map(&:to_i).each do |n|
    if previous == n
      check_double_digits[n] = 1 + (check_double_digits[n] || 0)
    end

    return false if n < previous

    previous = n
  end

  return check_double_digits.any? { |k, v| v == 1 }
end

min, max = File.read(ARGV[0]).strip.split('-')

puts (min..max)
  .select { |password| is_valid?(password) }
  .count
