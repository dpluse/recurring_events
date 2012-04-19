class CreateEvent < ActiveRecord::Migration
  def change
		create_table :events do |t|
			t.string :name
			t.string :description
			t.date :start_date
			t.date :end_date
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
