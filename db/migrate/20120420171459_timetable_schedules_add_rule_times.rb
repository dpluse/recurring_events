class TimetableSchedulesAddRuleTimes < ActiveRecord::Migration
  def change
		add_column :timetable_schedules, :name, :string
		add_column :timetable_schedules, :start_date, :datetime
		add_column :timetable_schedules, :end_date, :datetime
		add_column :timetable_schedules, :rule_start_time, :text
		add_column :timetable_schedules, :rule_end_time, :text
  end
end
