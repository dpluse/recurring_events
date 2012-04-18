class FullcalendarsController < ApplicationController
  
  # Returns events to the calendar via Ajax 
  # Params: 
  #   "start"=>"1333234800",  - Unix timestamp of calendar display interval start.
  #   "end"=>"1336863600",    - Unix timestamp of calendar display interval end
  #   "_"=>"1334658647101"}   - Anti-Caching parameter. Prevents browsers from caching the result.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def three_events
    puts "Asking for events between: #{Time.at(params[:start].to_i)} and #{Time.at(params[:end].to_i)} in #{controller_name}:#{action_name}!"
    now     = DateTime.now
    year    = now.year
    month   = now.month
    day     = now.day
    hour    = now.hour
    minute  = now.minute
    second  = now.second
    
    @events = [ 
      { :id => 111, :title => "Yahoo", :start => "#{year}-#{month}-#{day}", :url => "http://yahoo.com/" },
      { :id => 112, :title => "Google", :start => "#{year}-#{month}-#{day+1}", :url => "http://google.com/" },
      { :id => 113, :title => "Bing", :allDay => false, :url => "http://bing.com/", 
          :start => "#{year}-0#{month}-#{day+3}T#{hour}:#{minute}:00Z",
          :end => "#{year}-0#{month}-#{day+3}T#{hour+2}:#{minute}:00Z"
      },
      # { :id => 113, :title => "Bing", :allday => false, :start => "#{year}-#{month}-#{day+3}", :url => "http://bing.com/" }
    ]
    puts "Events: #{@events.inspect}"
    respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end
  
  
  def four_events
    @events = Events.new(params[:start], params[:end])
    respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render :xml => @events }
      format.js  { render :json => @events.find }
    end
  end
  
end