class EntryForm < FormModel

  include IceCube
  class_eval &ValidatesTimelinessSupport[{:start_date => :datetime}]

  Units = [Day = 'day', Week = 'week']
  Intervals = %w[0 1 2 3 4 5 6 7 8 9]
  Week_Days = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  Days_With_Letters = Week_Days.zip(%w[S M T W T F S])

  attr_accessible_accessors :interval, :unit, :start_date
  attr_accessible_accessors *Week_Days

  def_delegators :@model, :display_title, :schedule_yaml, :schedule_yaml=

  validates_date :start_date, :allow_blank => true
  validates_inclusion_of :unit, :in => Units
  validates_inclusion_of :interval, :in => Intervals
  validates_inclusion_of :complete, :in => %w[0 1], :allow_blank => true
  Week_Days.each { |day| validates_inclusion_of day, :in => %w[0 1], :allow_blank => true }

  before_edit {
    if not schedule_yaml.blank? and hash = YAML::load(schedule_yaml)
      schedule = Schedule.from_hash(hash)
    end

    if schedule and rule = schedule.rrules.first
      @start_date = schedule.start_date

      rule_hash = rule.to_hash
      @interval = rule_hash[:interval]

      case rule
      when DailyRule
        @unit = Day
      when WeeklyRule
        @unit = Week
        rule_hash[:validations][:day].try :each do |day_index|
          send "#{Week_Days[day_index]}=", 1
        end
      end

    else
      @start_date = Date.today
      @interval = 1
      @unit = Day
    end
  }

  before_save {
      sd = @start_date.blank? ?
          Date.today.to_all_day :
          @start_date.parse_date_in_timezone
      i = @interval.to_i
      schedule = Schedule.new(sd)


      rule = case @unit
        when Day
          Rule.daily i
        when Week
          Rule.weekly(i).day(
            *Week_Days.
            select { |day| send(day).to_i == 1 } )
      end

      schedule.add_recurrence_rule(rule)

      self.schedule_yaml = schedule.to_yaml
    end
  }
end
