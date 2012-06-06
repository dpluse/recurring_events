class RenameTimetableSchedules < ActiveRecord::Migration
  def change
  	rename_table :timetable_schedules, :event_schedules
  end
end