# Just some examples of how IceCube (ice_cube gem) can be used.
# http://seejohncode.com/ice_cube/
# https://github.com/seejohnrun/ice_cube/

require 'ice_cube'
include IceCube
require 'pp'

rules = []

def output(instance, index = nil)
  # puts "\n#{instance.to_s} (#{instance.class.name})"
  index_str = index.nil? ? "" : "#{index.to_s.rjust(3)}: "
  puts "\n#{index_str}#{instance.to_s}"
  puts "~~~~~~~~~~~~~~~~~~~~"
  puts "to_hash: " 
  pp instance.to_hash
  # puts "\nto_hash from_hash then to_hash"
  # pp Schedule.from_hash(instance.to_hash).to_hash

  # puts "\n.to_yaml: " 
  # puts instance.to_yaml
  puts '~~~~~~~~~~~~~~~~~~~~'
end

def output_to_hash(instance, index = nil)
  puts "examples = []" if index == 0
  puts "examples[#{index}] = \"#{instance.to_yaml}\""
  # puts "examples[#{index}] = #{instance.to_hash.inspect}"
  # puts instance.to_yaml.inspect
  # pp instance.to_hash
end

# The fridays in October that are on the 13th of the month
# rule_fri13oct = Rule.weekly.day(:friday).day_of_month(13).month_of_year(:october)
# schedule = Schedule.new(Time.now)
# output(schedule)

# The fridays in October that are on the 13th of the month
rules << Rule.yearly.month_of_year(:october).day_of_month(13).day(:friday)
rules << Rule.yearly.day_of_month(13).day(:friday).month_of_year(:october)
rules << Rule.yearly(1).day_of_month(13).day(:friday).month_of_year(:october)

rules << Rule.weekly(2).day(:friday).day_of_month(13).month_of_year(:october)
rules << Rule.weekly(2).day_of_month(13).day(:friday).month_of_year(:october)

rules << Rule.daily # every day
rules << Rule.daily(3) # every third day

rules << Rule.weekly # every week
rules << Rule.weekly(2).day(:monday, :tuesday) # every other week on monday and tuesday
rules << Rule.weekly(2).day(1, 2) # for programatic convenience (same as above)

rules << Rule.monthly.day_of_month(1, -1) # every month on the first and last days of the month
rules << Rule.monthly(2).day_of_month(15) # every other month on the 15th of the month
rules << Rule.monthly.day_of_week(:tuesday => [1, -1]) # every month on the first and last tuesdays of the month
rules << Rule.monthly(2).day_of_week(:monday => [1], :tuesday => [-1]) # every other month on the first monday and last tuesday
rules << Rule.monthly(2).day_of_week(1 => [1], 2 => [-1]) # for programatic convenience (same as above)

rules << Rule.yearly.day_of_year(100, -100) # every year on the 100th day from the beginning and end of the year
rules << Rule.yearly(4).day_of_year(-1) # every fourth year on new year's eve
rules << Rule.yearly.month_of_year(:january, :february) # every year on the same day as start_date but in january and february
rules << Rule.yearly(3).month_of_year(:march) # every third year in march
rules << Rule.yearly(3).month_of_year(3) # for programatic convenience (same as above)

rules << Rule.hourly # every hour on the same minute and second as start date
rules << Rule.hourly(2).day(:monday) # every other hour, on mondays

rules << Rule.minutely(10) # every 10 minutes
rules << Rule.minutely(90).day_of_week(:tuesday => [-1]) # every hour and a half, on the last tuesday of the month

rules.each_with_index do |rule, index|
  schedule = Schedule.new(Time.now)  
  schedule.add_recurrence_rule rule
  # output(schedule, index)  # Creates a human readable output.
  output_to_hash(schedule, index)  # Generates a Ruby parseable file, run with  ruby ./lib/ice_cube_examples.rb > ./lib/examples.rb
end

