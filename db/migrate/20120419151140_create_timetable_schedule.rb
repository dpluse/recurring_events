class CreateTimetableSchedule < ActiveRecord::Migration
  def change
		create_table :timetable_schedules do |t|
			t.text :schedule
			t.integer :event_duration
			t.datetime :start_time
			t.datetime :end_time
	    t.datetime :created_at
	    t.integer  :created_by_user_id
	    t.integer  :updated_by_user_id
	    t.datetime :updated_at
	    t.integer :timetable_id
		end
  end
end
