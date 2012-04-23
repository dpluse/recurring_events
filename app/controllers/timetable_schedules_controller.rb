class TimetableSchedulesController < ApplicationController
   before_filter :check_for_cancel, :only => [:create, :update]

  def index
    @timetable_schedules = TimetableSchedule.all 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timetable_schedules }
    end
  end


  def new
    @timetable_schedule = TimetableSchedule.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timetable_schedule }
    end
  end

  def create
    @timetable_schedule = TimetableSchedule.new(params[:timetable_schedule])
    @timetable_schedule.create_ice_cube_schedule
    respond_to do |format|
      if @timetable_schedule.save
        format.html { redirect_to(timetable_schedules_path, :notice => 'Timetable schedule was successfully created.') }
        format.xml  { render :xml => @timetable_schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timetable_schedule.errors }
      end
    end
  end


  def edit
    @timetable_schedule = TimetableSchedule.find(params[:id])
    #@timetable.before_edit
  end

  def update
    @timetable_schedule = TimetableSchedule.find(params[:id])
    @timetable_schedule.attributes = params[:timetable_schedule]
    respond_to do |format|
      if @timetable_schedule.save
        format.html { redirect_to(timetable_schedules_path, :notice => 'Schedule event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timetable_schedule.errors }
      end
    end
  end


  def destroy
    @timetable_schedule = TimetableSchedule.find(params[:id])
    @timetable_schedule.destroy
    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Timetable schedule was successfully removed.') }
      format.xml  { head :ok }
    end
  end


private 

  def check_for_cancel
    if params[:commit] == "Cancel"
      respond_to do |format|
        format.html { redirect_to(timetable_schedules_path, :notice => 'Timetable schedule was successfully cancelled - no changes were made.') }
        format.xml  { head :ok }
      end 
    end
  end

end