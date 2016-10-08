require 'date'

class EventMerger
  attr_reader :events 

  def initialize(events)
    raise ArgumentError.new("Events need to be provided within an Array") unless events.is_a? Array
    @events = events
  end 

  def merge!    
    group_events(uniq_dates) 
  end

  private 

  def uniq_dates
    begin
      events.map { |event| normalize_date(event[:date]) }.uniq
    rescue 
      raise ArgumentError.new("Events need to be in the form of a Hash")
    end 
  end

  def normalize_date(date)
    begin
      Date.parse(date).strftime("%Y-%m-%d")
    rescue
      raise ArgumentError.new("Event did not include date")
    end 
  end 

  def group_events(dates)
    event_array = []
    dates.each do |date|
      grouped_events = events.select { |event| event[:date] == date }
      event_array << merge_keys(grouped_events, date)
    end
    event_array 
  end 

  def merge_keys(events, date)
    events.inject({date: date}) do |merged_hash, event|
      event.each do |key, value|
        next if key == :date
        if merged_hash.key?(key)
          merged_hash[key] = ([merged_hash[key]] <<  value).flatten
        else 
          merged_hash[key] = value
        end 
      end 
      merged_hash
    end 
  end
end