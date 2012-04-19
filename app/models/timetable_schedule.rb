class TimetableSchedule < ActiveRecord::Base
  include IceCube

  belongs_to :timetable


  RULE_TYPES = %w(rrule add_recurrence_rule exrule add_exception_rule extime add_exception_time rtime add_recurrence_time)
  attr_accessor :rules
  serialize :schedule, Hash


  def schedule=(new_schedule)
   write_attribute(:schedule, new_schedule.to_hash)
  end


  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end
  
  
  def add_rule(rule_type, rule)
    raise ArgumentError.new('rule must be an instance of IceCube::Rule') unless rule.kind_of? IceCube::Rule
    raise ArgumentError.new("rule_type must one of #{RULE_TYPES.join(', ')} ") unless RULE_TYPES.include? rule_type.to_s
    @rules ||= []
    @rules << {rule_type: rule_type.to_sym, rule: rule}
    self.schedule = get_schedule
  end
  

  def set_duration(seconds)
    raise ArgumentError.new('seconds must be be a Fixnum (integer)') unless seconds.kind_of? Fixnum
    @duration = seconds
  end
  

  def set_end_time(date_time)
    raise "Not implemented"
  end
  

  def get_schedule
    new_schedule = Schedule.new(start_time, {end_time: end_time})
    # new_schedule = Schedule.new(Time.now)
    @rules.each do |rule|
      # puts "Creating rule of '#{rule[:rule_type]}' type and rule: #{rule[:rule].inspect}"
      new_schedule.send(rule[:rule_type], rule[:rule])
    end
    # puts "New Schedule: #{new_schedule.inspect}"
    self.schedule = new_schedule
    new_schedule
  end
  

  def schedule_info
    end_time_msg = end_time ? " #{end_time}" : " with no end time."
    "#{schedule} starting at #{start_time}#{end_time_msg}"
  end

end