#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'

options = OpenStruct.new
options.rows = 10
options.columns = 10
OptionParser.new do |opts|
  opts.on('-r', '--rows [INTEGER]', 'Number of rows', Integer) do |x|
    options.rows = x
  end
  opts.on('-c', '--columns [INTEGER]', 'Number of columns', Integer) do |x|
    options.columns = x
  end
end.parse!

require 'rubygems'
require 'csv'
require 'webster'

webster = Webster.new

ARGV << '/dev/stdout' if ARGV.empty?
ARGV.each do |file_name|
  CSV.open(file_name, 'w') do |csv|
    options.rows.times do |row_index|
      row = []
      options.columns.times do |column_index|
        row << webster.random_word
      end
      csv << row
    end
  end
end
