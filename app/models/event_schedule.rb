require 'pp'

class EventSchedule < ActiveRecord::Base

  include IceCube

  validate :rules_are_unique

  INTERVAL_PERIOD = %w(daily weekly monthly yearly)

  attr_accessor :my_schedule, :schedule_rules, :rule_validations, :rule_times, :tester

  serialize :schedule, Hash

  def tester
    { :rule_type => "weekly", :interval => 2 }
  end

  def tester=(stuff)
    { :rule_type => "#{stuff}", :interval => 2 }
  end

  def output(instance)
    puts "\n#{instance.to_s} (#{instance.class.name})"
    puts "~~~~~~~~~~~~~~~~~~~~"
    puts "to_hash: " 
    pp instance.to_hash

    puts "\n.to_yaml: " 
    puts instance.to_yaml
    puts '~~~~~~~~~~~~~~~~~~~~'
  end

  def schedule=(new_schedule)
    write_attribute(:schedule, new_schedule.to_hash)
  end

  def schedule
    Schedule.from_hash(read_attribute(:schedule))
  end

  def create_schedule
    new_schedule = Schedule.new(self.start_date.blank? ? Time.now : self.start_date, {end_time: self.end_date})
    if !schedule_rules.nil? 
      schedule_rules.each do |rule|
        new_schedule.add_recurrence_rule create_ice_cube_rule(rule)
      end
    end
    new_schedule.inspect
    output(new_schedule)
    self.schedule = new_schedule
  end

  def edit_ice_cube_schedule
    my_schedule = {}
    my_schedule = schedule.to_hash
    @schedule_rules = []
    output(my_schedule)
    my_schedule[:rrules].each do |rule|
      event_rule = {}
      event_rule[:rule_type] = "weekly"
      event_rule[:interval] = rule[:interval]
      event_rule[:rule_times] = rule[:events_times]
      @schedule_rules << event_rule
    end
    puts "schedule rules: " + @schedule_rules.inspect
  end

  private
 
  def create_ice_cube_rule(rule)
    if is_valid_ice_cube_rule_interval_period?(rule) 
      ice_cube_rule = Rule.send(rule[:rule_type].to_sym, (rule[:interval].to_i || 1), :sunday, create_rule_times(rule))
      if rule[:rule_validations].present?
        rule[:rule_validations].each do |validation_element|
          validation_element.each do |key, value|
            # TODO: this should be able to take multiple days
            ice_cube_rule.send(key, value[0].downcase.to_sym)
          end
        end
      end
    end
    return ice_cube_rule 
  end

  def is_valid_ice_cube_rule_interval_period?(rule)
    return true if INTERVAL_PERIOD.include? rule[:rule_type]
    raise ArgumentError.new('Rule is not one of the following ' + INTERVAL_PERIOD.to_sentence(:last_word_connector => ' or ') ) 
    return false
  end

  def create_rule_times(rule)
    rule_times = []
    if rule[:rule_times].present?
      rule[:rule_times].each do |event_time|
        event_times = {}
        event_times[:start_time] = to_datetime_from_param(event_time, 'start_time')
        event_times[:end_time] = to_datetime_from_param(event_time, 'end_time')
        rule_times << event_times
      end
    end
    return rule_times
  end

  def to_datetime_from_param(time, param_name)
    DateTime.new(time["#{param_name}(1i)"].to_i, time["#{param_name}(2i)"].to_i, time["#{param_name}(3i)"].to_i, time["#{param_name}(4i)"].to_i, time["#{param_name}(5i)"].to_i)
  end
  
  def rules_are_unique
    validate_rule_unique(schedule_rules)  
  end

  def validate_rule_unique(rules)
    rules.each_with_index do |rule, index|
      for current_index in (index+1)..(rules.length)
        errors.add(:event_schedule, "Rule #{index} and Rule #{current_index} are duplicate rules.") if rule == rules[current_index]
      end
    end 
  end

end