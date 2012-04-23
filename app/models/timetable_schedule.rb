class TimetableSchedule < ActiveRecord::Base
  include IceCube

  belongs_to :timetable


  INTERVAL_PERIOD = %w(daily weekly monthly yearly)

  # RULE_TYPES = %w(rrule add_recurrence_rule exrule add_exception_rule extime add_exception_time rtime add_recurrence_time)
  
  attr_accessor :rules, :rule_validations
  serialize :schedule, Hash
  serialize :rule_start_time, Array
  serialize :rule_end_time, Array


  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end


  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end


  def create_ice_cube_schedule
    new_schedule = Schedule.new(self.start_date.blank? ? Time.now : self.start_date, {end_time: self.end_date})
    rules.each do |rule|
      new_schedule.add_recurrence_rule create_rule(rule)
    end
    
    self.schedule = new_schedule
  end


  def create_rule(rule)
    if INTERVAL_PERIOD.include? rule[:rule_type]
      interval = rule[:interval].blank? ? 1 : rule[:interval].to_i

      Rule.send(rule[:rule_type].to_s, interval.to_s)
    else
      raise ArgumentError.new('Rule is not one of the following ' + INTERVAL_PERIOD.to_sentence(:last_word_connector => ' or ') ) 
    end
  end


  # def add_rule(rule_type, rule)
  #   raise ArgumentError.new('rule must be an instance of IceCube::Rule') unless rule.kind_of? IceCube::Rule
  #   raise ArgumentError.new("rule_type must one of #{RULE_TYPES.join(', ')} ") unless RULE_TYPES.include? rule_type.to_s
  #   @rules ||= []
  #   @rules << {rule_type: rule_type.to_sym, rule: rule}
  #   self.schedule = get_schedule
  # end
  

  # def set_duration(seconds)
  #   raise ArgumentError.new('seconds must be be a Fixnum (integer)') unless seconds.kind_of? Fixnum
  #   @duration = seconds
  # end
  

  # def set_end_time(date_time)
  #   raise "Not implemented"
  # end
  

  # def get_schedule
  #   new_schedule = Schedule.new(start_time, {end_time: end_time})
  #   # new_schedule = Schedule.new(Time.now)
  #   @rules.each do |rule|
  #     # puts "Creating rule of '#{rule[:rule_type]}' type and rule: #{rule[:rule].inspect}"
  #     new_schedule.send(rule[:rule_type], rule[:rule])
  #   end
  #   # puts "New Schedule: #{new_schedule.inspect}"
  #   self.schedule = new_schedule
  #   new_schedule
  # end

  

  # def schedule_info
  #   end_time_msg = end_time ? " #{end_time}" : " with no end time."
  #   "#{schedule} starting at #{start_time}#{end_time_msg}"
  # end

end