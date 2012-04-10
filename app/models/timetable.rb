class Timetable < ActiveRecord::Base

	belongs_to :timetable_period
	has_many :timetable_event_periods, :dependent => :destroy
		accepts_nested_attributes_for :timetable_event_periods

    validates :name, :presence => true
    validates :timetable_period_id, :presence => true

end