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
    @events = FullCalendarEvents.new(params[:start], params[:end])
    respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render :xml => @events }
      format.js  { render :json => @events.find }
    end
  end
  
  def five_good_events
    respond_to do |format|
      format.js  { render :json => good_events }
    end
  end
  
  private
  
  def good_events
    now     = DateTime.now
    year    = now.year
    month   = now.month
    day     = now.day
    day_mon = now.beginning_of_week.day
    day_sun = now.end_of_week.day
    hour    = now.hour
    minute  = now.minute
    second  = now.second
    
    events = []
    %w(Monday Tuesday Wednesday Thursday Friday).each_with_index do |day, index|
      events << { :id => "#{index}1".to_i, :title => "#{day} morning", :allDay => false, :editable => false, :className => 'good_events',
                  :start => Time.new(year, month, day_mon + index, 8, 0, 0).to_i,
                  :end => Time.new(year, month, day_mon + index, 12, 0, 0).to_i
                }
      events << { :id => "#{index}2".to_i, :title => "#{day} afternoon", :allDay => false, :editable => false, :className => 'good_events',
                  :start => Time.new(year, month, day_mon + index, 13, 0, 0).to_i,
                  :end => Time.new(year, month, day_mon + index, 17, 0, 0).to_i
                }
    end
    events
  end
  
end