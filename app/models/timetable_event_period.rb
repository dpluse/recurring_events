class TimetableEventPeriod < ActiveRecord::Base
	belongs_to :timetable
	has_many :timetable_event_rules, :dependent => :destroy
		accepts_nested_attributes_for :timetable_event_rules
end