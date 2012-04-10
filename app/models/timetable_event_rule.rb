class TimetableEventRule < ActiveRecord::Base
	belongs_to :timetable_event_period
	belongs_to :event_period
end