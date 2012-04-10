class Timetable < ActiveRecord::Base
	include IceCube

	belongs_to :timetable_period
	has_many :timetable_event_periods, :dependent => :destroy
		accepts_nested_attributes_for :timetable_event_periods

    validates :name, :presence => true
    validates :timetable_period_id, :presence => true

	def schedule
    	new_schedule = Schedule.new(start_date)
    	new_schedule.add_recurrence_time(Time.now)
    	new_schedule.add_exception_time(Time.now + 1.day)
    	return new_schedule
  	end

end