require 'ice_cube'
include IceCube

rule = Rule.daily(1).day(:monday, :tuesday, :wednesday, :thursday, :friday)
rule1 = Rule.daily(1).day(:wednesday)
schedule = Schedule.new(Time.now)  
schedule.add_recurrence_rule rule
schedule.add_recurrence_time Time.now + 60
puts "Schedule: #{schedule.to_s}"
puts "Schedule: #{schedule.to_yaml}"
puts "Schedule: #{schedule.to_hash.inspect}"

# schedule.all_occurrences
puts schedule.occurrences_between(Time.now, Time.now + 60 * 60 * 24 * 7 * 52).inspect