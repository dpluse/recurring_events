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

  attr_accessor :start_date, :interval, :day_of_month, :day, :month_of_year, :rule_type, :rule_hash
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
		rule1 = Rule.yearly(1).day_of_month(13).day(:friday).month_of_year(:october, :november)
		rule2 = Rule.yearly(1).day_of_month(14).day(:wednesday).month_of_year(:december)
    rule3 = Rule.daily(3).day(:tuesday)
    #schedule.add_recurrence_rule rule1
    #schedule.add_recurrence_rule rule2
    schedule.add_recurrence_rule rule3
    schedule.to_hash
 	end

  def before_edit
    if !schedule.blank?
      edit_schedule = schedule
      if rule = edit_schedule.rrules.first
        @start_date = schedule.start_date
        rule_hash = rule.to_hash
        @interval = rule_hash[:interval]
        case rule
        when DailyRule
          @rule_type = :daily
        end
      end  
    end        
  end

	def before_save
		new_schedule = Schedule.new(self.start_date.blank? ? Time.now : self.start_date)
    
    case self.rule_hash[0]["rule_type"].to_s
    when 'daily'
      i = self.rule_hash[0]["interval"].to_i.blank? ? 1 : self.rule_hash[0]["interval"].to_i
      rule = Rule.daily(i)

      new_schedule.add_recurrence_rule Rule.daily(i)
      self.schedule = new_schedule
  	end

  	# Interate through the virtualrules hash and add the rules
  	
	end
end