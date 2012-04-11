class Timetable < ActiveRecord::Base
	include IceCube

	# Returns a scheule object as a hash 
	# {:start_date=>2012-04-10 16:53:41 +0100,
	#  :rrules=>
	#   [{:validations=>{:day_of_month=>[13], :day=>[5], :month_of_year=>[10, 11]},
	#     :rule_type=>"IceCube::YearlyRule",
	#     :interval=>1}],
	#  :exrules=>[],
	#  :rtimes=>[],
	#  :extimes=>[]}

    attr_accessor :start_date, :rules_hash, :interval, :day_of_month, :day, :month_of_year, :rule_type

    validates :name, :presence => true
    serialize :schedule, Hash

	week_days = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
	months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
	period = [:daily, :weekly, :monthly, :yearly]

 	def schedule=(new_schedule)
    	write_attribute(:schedule, new_schedule.to_hash)
  	end

  	def schedule
    	Schedule.from_hash(read_attribute(:schedule))
  	end

	def schedule_test
		schedule = Schedule.new(Time.now)  
		rule = Rule.yearly(1).day_of_month(13).day(:friday).month_of_year(:october, :november)
		schedule.add_recurrence_rule rule
		schedule.to_hash
  	end

  	def before_save
  		schedule = Schedule.new(@start_date.blank? ? Time.now : @start_date)
    	i = @interval.blank? ? 1 : @interval.to_i
    	rule = case @rule_type
        when :daily
          Rule.daily(i)
        when :weekly
          Rule.weekly(i).day(
            *Week_Days.
            select { |day| send(day).to_i == 1 } )
      	end

      	# Interate through the vritualrules hash and add the rules
      	#schedule.add_recurrence_rule(rule)

  	end
end