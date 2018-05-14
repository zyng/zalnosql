#!/usr/bin/ruby

require 'mongo'
require_relative '../lib/connection'

conn = Connection.new
db = conn.client.database
incidents = conn.incidents

# prompt user for inputs
puts "\nReady to input a new incident document.\n"
puts "First, the required fields.\n\n"

# strip newline character from input with chomp
puts "Incident number: \n"
IncidntNum = gets.chomp

puts "\n Category: \n"
Category = gets.chomp

puts "\n Descript: \n"
Descript = gets.chomp


puts "\n DayOfWeek: \n"
DayOfWeek = gets.chomp

puts "\n Date (month/day/year): \n"
Date = gets.chomp

puts "\n Time (HH:MM): \n"
Time = gets.chomp

puts "\n PdDistrict: \n"
PdDistrict = gets.chomp

puts "\n Resolution: \n"
Resolution = gets.chomp

puts "\n Address: \n"
Address = gets.chomp

puts "\n coincidence X: \n"
X = gets.chomp

puts "\n coincidence Y: \n"
Y = gets.chomp

puts "\n Location (Y,X): \n"
Location = gets.chomp

puts "\n PdId: \n"
PdId = gets.chomp


# create a document for insertion
insert_doc = { 'IncidntNum' => IncidntNum,
               'Category' => Category,
               'Descript' => Descript,
               'DayOfWeek' => DayOfWeek,
               'Date' => Date,
               'Time' => Time,
               'PdDistrict' => PdDistrict,
			   'Resolution' => Resolution,
               'Address' => Address,
               'X' => X,
			   'Y' => Y,
			   'Location' => Location,
			   'PdId' => PdId
             }

# use the insert_one method on the restaurants collection
result = incidents.insert_one( insert_doc )

# check for success or failure
if result.n == 1
  puts "Document successfully created.\n#{insert_doc}"
else
  puts "Document creation failed."
end
