class TimetablesController < ApplicationController
   before_filter :check_for_cancel, :only => [:create, :update]
  # GET /timetables
  # GET /timetables.xml
  def index
    @timetables = Timetable.all 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  # GET /timetables/new
  # GET /timetables/new.xml
  def new
    @timetable = Timetable.new
    @timetable.schedule_test
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timetable }
    end
  end

  def create
    puts "parmas: " + params.inspect
    @timetable = Timetable.new(params[:timetable])
    puts "timetable= "+@timetable.rule_hash[0]["rule_type"].inspect
    @timetable.before_save
    respond_to do |format|
      if @timetable.save
        format.html { redirect_to(timetables_path, :notice => 'timetabled event was successfully created.') }
        format.xml  { render :xml => @timetable, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /avoid_times/1/edit
  def edit
    @timetable = Timetable.find(params[:id])
    @timetable.before_edit
  end

  def update
    @timetable = Timetable.find(params[:id])
    @timetable.attributes = params[:timetable]
    respond_to do |format|
      if @timetable.save
        format.html { redirect_to(timetables_path, :notice => 'Schecule event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acheduled_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /avoid_times/1
  # DELETE /avoid_times/1.xml
  def destroy
    @timetable = Timetable.find(params[:id])
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'timetabled event was successfully removed.') }
      format.xml  { head :ok }
    end
  end


private 

  def check_for_cancel
    if params[:commit] == "Cancel"
      respond_to do |format|
        format.html { redirect_to(timetables_path, :notice => 'timetabled Event was successfully cancelled - no changes were made.') }
        format.xml  { head :ok }
      end 
    end
  end

end