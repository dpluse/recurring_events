class ChangeTimetableAttributes < ActiveRecord::Migration
  def change
		remove_column :timetables, :schedule
  end
end
