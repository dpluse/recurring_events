class Timetable < ActiveRecord::Base
	include IceCube

  has_many :timetable_schedules
  has_many :events


  attr_accessor :schedules
  
  
  def events_between(start_event_time, end_event_time)
    all_events = []
    timetable_schedules.each do |timetable_schedule|
      occcurrences = timetable_schedule.schedule.occurrences_between(start_event_time, end_event_time)
      all_events += occcurrences.collect { |start_time| create_event(start_time, timetable_schedule.event_duration) }
    end
    all_events
  end
  
  
  
  private
  
  def create_event(start_time, event_duration)
    event = Event.new()
    event.name = name
    event.set_start_time_and_duration(start_time, event_duration)
    event.save
    event
  end

end