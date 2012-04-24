class FullCalendarEvents
  include IceCube
  require 'digest/sha1'
  
  attr_accessor :calendar_start, :calendar_end
  attr_reader :timetable_schedules
  
  def initialize(calendar_start, calendar_end)
    @calendar_start = Time.at(calendar_start.to_i) if (calendar_start.to_i.to_s == calendar_start)
    @calendar_end   = Time.at(calendar_end.to_i) if (calendar_end.to_i.to_s == calendar_end)
  end
  
  
  def timetable_schedules
    @timetable_schedules ||= TimetableSchedule.order(:id).all
  end
  
  
  def find
    raise "Calendar start and end times are not defined. Maybe the parameters for the constructor were invalid?" unless (@calendar_start && @calendar_end)
    # puts "\n~~~\nFinding events between #{calendar_start.to_s} - #{calendar_end.to_s}\n~~~"
    occurrences = find_event_occurrences(timetable_schedules, calendar_start, calendar_end)
    # puts "\nOccurrances: #{occurrences.inspect}\n~~~~~~~~~~~~~"
    make_events(occurrences)
  end
  
  
  def find_event_occurrences(events, start, end_)
    events.map do |timetable_schedule|
      # puts "\ntimetable1: #{timetable.inspect}"
      # puts "schedule3: #{timetable.schedule.to_s}"
      occurrances = timetable_schedule.schedule.occurrences_between(start, end_)
      puts "***************************"+occurrances.inspect
      if occurrances.empty?
        nil
      else
        event = {name: timetable.name,
                 occurrances: occurrances}
      end
    end.compact
  end
  
  
  def make_events(occurrences)
    events = []
    occurrences.each do|occurrance|
      # puts "Occurrance: #{occurrance.inspect}"
      occurrance[:occurrances].each do |event|
        # puts "Event: #{event.inspect}"
        events << make_event(event, occurrance[:name])
      end
    end
    events
  end
  
  
  def make_event(occurrance, name)
    {
      id: make_event_id(name + occurrance.to_s),
      title: name,
      allDay: false,
      start: occurrance,
      :end => occurrance + 3600,  # end time is hard coded to + 1 hour.
    }
  end
  
  
  private
  
  def make_event_id(string)
     Digest::SHA1.hexdigest string
  end
end

# Some notes:
# Date stamp about a month before now (Time.now - 3600 * 24 * 30).to_i  --- 1332082045 (start)
# Date stamp about a month from now (Time.now + 3600 * 24 * 30).to_i    --- 1337266031  (end)
# A year bfore today DateTime.now.years_ago(1).to_i --- 1303054215 (start)
# A year from now DateTime.now.years_since(1) --- 1366212597 (end)
# Beginning of the current week -- DateTime.now.beginning_of_week.to_i -- 1334530800
# End of current week -- DateTime.now.end_of_week.to_i -- 1335135599