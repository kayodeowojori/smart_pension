#!/usr/bin/ruby
# frozen_string_literal: true

require './log_processor.rb'

result = LogProcessor.new(filename: ARGV[0]).process

puts '===================='
puts 'Page views by volume'
puts '===================='
puts result[:page_views]
puts 'end of page views'

puts '============================'
puts 'Unique page views by volume'
puts '==========================='
puts result[:unique_views]
puts 'end of unique page views'
