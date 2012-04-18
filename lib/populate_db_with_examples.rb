require 'ice_cube'
include IceCube
require './lib/examples.rb'

# puts examples[1].inspect

examples.each do |example|
  schedule = Schedule.from_yaml(example)
  puts "\n------------------"
  puts schedule.to_s
  puts schedule.to_hash.inspect
  if false
    puts "Creating schedule."
    Timetable.find_or_create_by_name(name: schedule.to_s, schedule: schedule)
  else
    puts "Will not create Timetable objects."
  end
end