class RemoveTimeAttrFromTimetableSchedule < ActiveRecord::Migration
  def up
  	remove_column :timetable_schedules, :event_duration
  	remove_column :timetable_schedules, :start_time
  	remove_column :timetable_schedules, :end_time
    remove_column :timetable_schedules, :timetable_id
  end

  def down
  	add_column :timetable_schedules, :event_duration, :integer
  	add_column :timetable_schedules, :start_time, :datetime
  	add_column :timetable_schedules, :end_time, :datetime
    add_column :timetable_schedules, :timetable_id, :integer
  end
end
