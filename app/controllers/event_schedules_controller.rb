class EventSchedulesController < ApplicationController
   before_filter :check_for_cancel, :only => [:create, :update]

  def index
    @event_schedules = EventSchedule.all 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event_schedules }
    end
  end

  def new
    @event_schedule = EventSchedule.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event_schedule }
    end
  end

  def create
    @event_schedule = EventSchedule.new(params[:event_schedule])
    # Check for duplicate rules before saving the EventSchedule.
    # Note: Ice_cube will not allow duplicate rule entries. Therefore, need to validate that the user has not entered duplicate rules before saving.
    @event_schedule.create_schedule
    respond_to do |format|
      if @event_schedule.save
        format.html { redirect_to(event_schedules_path, :notice => 'Timetable schedule was successfully created.') }
        format.xml  { render :xml => @event_schedule }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event_schedule.errors }
      end
    end
  end

  def edit
    @event_schedule = EventSchedule.find(params[:id])
    @event_schedule.schedule_rules = [{:rule_type => "weekly", :interval => 1}, {:rule_type=>"weekly", :interval => 2}]
  end

  def update
    @event_schedule = EventSchedule.find(params[:id])
    @event_schedule.attributes = params[:timetable_schedule]
    respond_to do |format|
      if @event_schedule.save
        format.html { redirect_to(event_schedules_path, :notice => 'Schedule event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event_schedule.errors }
      end
    end
  end

  def destroy
    @event_schedule = EventSchedule.find(params[:id])
    @event_schedule.destroy
    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Timetable schedule was successfully removed.') }
      format.xml  { head :ok }
    end
  end


private 

  def check_for_cancel
    if params[:commit] == "Cancel"
      respond_to do |format|
        format.html { redirect_to(event_schedules_path, :notice => 'Timetable schedule was successfully cancelled - no changes were made.') }
        format.xml  { head :ok }
      end 
    end
  end

end