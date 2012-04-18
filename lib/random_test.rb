require 'ice_cube'
include IceCube

rule = Rule.weekly(2).day(:monday, :tuesday)
schedule = Schedule.new(Time.now)  
schedule.add_recurrence_rule rule
puts "Schedule: #{schedule.to_s}"
puts "Schedule: #{schedule.to_yaml}"
puts "Schedule: #{schedule.to_hash.inspect}"

# schedule.all_occurrences
puts schedule.occurrences_between(Time.now, Time.now + 60 * 60 * 24 * 7 * 52).inspect