class CreateRecurringEvents < ActiveRecord::Migration
	def change
		create_table :timetables do |t|
			t.string :name
			t.text :schedule
	    t.datetime :created_at
	    t.integer  :created_by_user_id
	    t.integer  :updated_by_user_id
	    t.datetime :updated_at
		end
  end
end