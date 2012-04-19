class Event < ActiveRecord::Base

  belongs_to :timetable
  
  
  def start_date=(start_date)
    if start_date.is_a? Date
      @start_date = start_date
      @end_date = start_date if @end_date.nil? # Sets the end date to the same as the start date.
    else
      raise "start_date must be an instance of Date."
    end
  end
  

  def end_date=(end_date)
    if end_date.is_a? Date
      if start_date <= end_date
        @end_date = end_date
      else
        raise "end date must not be before start date"
      end
    else
      raise "end_date must be an instance of Date."
    end
  end
  
  
  def set_times(time_start, time_end) # takes two hashes, start and end times with keys hours, minutes and seconds
    set_start_time(time_start[:hours], time_start[:minutes], time_start[:seconds])
    set_end_time(time_end[:hours], time_end[:minutes], time_end[:seconds])
  end
  
  
  def set_time_and_duration(time_start, duration) # takes time hash with hours, minutes and seconds, and an integer with duration.
    set_start_time(time_start[:hours], time_start[:minutes], time_start[:seconds])
    raise ArgumentError.new('duration must be an integer denoting the duration in seconds') unless duration.is_a? Fixnum
    @end_time = @start_time + duration
    @end_date = @end_time.to_date
  end
  
  
  def set_start_time_and_duration(start_time, duration) # Takes a time object and an integer with duration
    raise ArgumentError.new('start_time must be an instance of Time') unless start_time.is_a? Time
    raise ArgumentError.new('duration must be an integer denoting the duration in seconds') unless duration.is_a? Fixnum
    @start_time = start_time
    @end_time   = @start_time + duration
    @start_date = @start_time.to_date
    @end_date   = @end_time.to_date
  end
  
  
  def start_date_set?
    !start_date.nil?
  end
  
  
  def end_date_set?
    !end_date.nil?
  end
  
  
  def start_time_set?
    !start_time.nil?
  end
  
  
  def end_time_set?
    !end_time.nil?
  end
  
  
  def is_all_day?
    !(start_time_set? and end_time_set?)
  end
  
  def duration
    if (start_date == end_date) and is_all_day?
      86400.0 # One day in seconds
    elsif is_all_day?
      end_date.to_time - start_date.to_time
    else
      end_time - start_time
    end
    
  end
  
  
  def info_array
    ["       Name: #{name}",
    "Description: #{description}",
    " Start date: #{start_date.to_s.ljust(24)} Set?: #{start_date_set?.to_s}",
    " Start time: #{start_time.to_s.ljust(24)} Set?: #{start_time_set?.to_s}",
    "   End date: #{end_date.to_s.ljust(24)} Set?: #{end_date_set?.to_s}",
    "   End time: #{end_time.to_s.ljust(24)} Set?: #{end_time_set?.to_s}",
    "    All day: #{is_all_day?.to_s}",
    "   Duration: #{duration.round.to_s} seconds = #{((duration / 60) / 60).round(2)} hours",
    ]
  end
  
  
  def info(join_str = "\n")
    return info_array.join(join_str)
  end
  
  
  
  private

  def set_start_time(hours, minutes, seconds = nil)
    seconds ||= 0
    raise "Start date is not set, unable to create start time." unless start_date.is_a? Date
    raise "Hours must be between 0 and 23" unless (0..23).include? hours
    raise "Minutes must be between 0 and 59" unless (0..59).include? minutes
    raise "Seconds must be between 0 and 59" unless (0..59).include? seconds
    @start_time = Time.utc(start_date.year, start_date.month, start_date.mday, hours, minutes, seconds)
  end
  
  def set_end_time(hours, minutes, seconds = nil)
    seconds ||= 0
    # raise "End date is not set, unable to create end time." unless start_date.is_a? Date
    unless start_date.is_a? Date or end_date.is_a? Date
      raise "Start date or End date are not set, unable to create end time."
    end
    raise "Hours must be between 0 and 23" unless (0..23).include? hours
    raise "Minutes must be between 0 and 59" unless (0..59).include? minutes
    raise "Seconds must be between 0 and 59" unless (0..59).include? seconds
    @end_time = Time.utc(end_date.year, end_date.month, end_date.mday, hours, minutes, seconds)
  end
  
end