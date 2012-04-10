class CreateRecurringEvents < ActiveRecord::Migration
	def change
		create_table :timetables do |t|
			t.string :name
			t.integer :timetable_period_id
		    t.datetime :created_at
		    t.integer  :created_by_user_id
		    t.integer  :updated_by_user_id
		    t.datetime :updated_at
		end

	  	create_table :timetable_event_periods do |t|
	  		t.integer :seq_no
	 		t.integer :timetable_id
		    t.string  :next_event
		    t.string  :end_event
		    t.datetime :created_at
		    t.integer  :created_by_user_id
		    t.integer  :updated_by_user_id
		    t.datetime :updated_at
		end

	  	create_table :timetable_event_rules do |t|
	  		t.integer :seq_no
	 		t.integer :timetable_event_period_id
	  		t.integer :event_period_recurrance
	  		t.integer :event_period_number
	  		t.integer :event_period_id
		    t.datetime :created_at
		    t.integer  :created_by_user_id
		    t.integer  :updated_by_user_id
		    t.datetime :updated_at
		end

		create_table :timetable_periods do |t|
		    t.integer  :seq_no
		    t.string   :name
		    t.integer  :scale
		    t.text     :description
		    t.datetime :created_at
		    t.integer  :created_by_user_id
		    t.integer  :updated_by_user_id
		    t.datetime :updated_at
  		end

 		create_table :event_periods do |t|
		    t.integer  :seq_no
		    t.string   :name
		    t.integer  :scale
		    t.text     :description
		    t.datetime :created_at
		    t.integer  :created_by_user_id
		    t.integer  :updated_by_user_id
		    t.datetime :updated_at
  		end
  	end
end