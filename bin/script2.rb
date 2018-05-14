#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'
require 'squid'
require 'prawn'


conn = Connection.new
db = conn.client.database
incidents = conn.incidents


results = incidents.aggregate([
  {'$group' => { _id: {day: "$DayOfWeek"}, 'count' => { '$sum' => 1}}},
  {'$sort' => {count: -1}}
  ])
arr=[]
for i in 0..results.to_a.size()-1
  arr << results.to_a[i][:_id][:day]
  arr << Integer(results.to_a[i][:count])
end
h=Hash[*arr]

  Prawn::Document.generate("day.pdf") do
    data = {incidents: h}
    chart data
  end
