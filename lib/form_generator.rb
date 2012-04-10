# Proof of concept to parse an schedule's hash into a more suitable hash for using in an HTML form.

require 'ice_cube'
include IceCube
require 'pp'


# Turns this hash (coming from schedule.to_hash)
# 
# {:start_date=>2012-04-10 16:53:41 +0100,
#  :rrules=>
#   [{:validations=>{:day_of_month=>[13], :day=>[5], :month_of_year=>[10, 11]},
#     :rule_type=>"IceCube::YearlyRule",
#     :interval=>1}],
#  :exrules=>[],
#  :rtimes=>[],
#  :extimes=>[]}
# 
# 
# Into this hash
# {:start_date=>2012-04-10 16:53:41 +0100,
#  :rrules=>
#   [{:interval=>1,
#     :rule_type=>"IceCube::YearlyRule",
#     :validations=>
#      [{:validation=>:day_of_month, :values=>[13]},
#       {:validation=>:day, :values=>[5]},
#       {:validation=>:month_of_year, :values=>[10, 11]}]}]}
# 
# Main difference is the use of explicit keys rather than having meanings in the keys.
# From: :month_of_year=>[10, 11]
# To:   {:validation=>:month_of_year, :values=>[10, 11]}
# This should make it easier to loop over the values to generate the form.


rule = Rule.yearly(1).day_of_month(13).day(:friday).month_of_year(:october, :november)
schedule = Schedule.new(Time.now)  
schedule.add_recurrence_rule rule

schedule_hash = schedule.to_hash

def to_form_hash(input)
  output = {}
  output[:start_date] = input[:start_date]
  output[:rrules] = []
  input[:rrules].each do |rrule| # Note: Only parses rrules at the moment!
    puts "rrule.inspect: #{rrule.inspect}"
    output_rrule = {}
    output_rrule[:interval] = rrule[:interval]
    output_rrule[:rule_type] = rrule[:rule_type]
    output_rrule[:validations] = []
    rrule[:validations].each do |validation|
      puts "validation.inspect: #{validation.inspect}"
      output_rrule[:validations] << {validation: validation[0], values: validation[1]}
    end
    output[:rrules] << output_rrule
  end
  output 
end

form_hash = to_form_hash(schedule_hash)

puts "~~~~~~~~~~~~~~"
puts "Schedule hash:"
pp schedule_hash
puts "Form hash:"
pp form_hash
puts "~~~~~~~~~~~~~~"