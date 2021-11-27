#!/usr/bin/env ruby

puts File
  .readlines(ARGV[0])
  .map { |x| (x.to_i / 3).floor - 2 }
  .sum
