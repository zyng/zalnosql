#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'

options = {}
optparse = OptionParser.new do |opt|
  opt.on('-t', '--time number') { |o| options[:time] = o }
end

begin
  optparse.parse!
rescue OptionParser::MissingArgument
  puts "\nUse -l <numer> Time statistic.\n"
end

if options[:time]
    time=options[:time]
else
  time="14:00"
end

conn = Connection.new
db = conn.client.database
incidents = conn.incidents

results = incidents.aggregate([
    {"$match" => { Time: time}},
    {'$group' => { '_id' => '$Category', 'count' => { '$sum' => 1}}},
    {'$sort' => {count: -1}},
    ])


puts results.to_a