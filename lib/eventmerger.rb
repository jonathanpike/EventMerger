class EventMerger
  def self.merge!(events)
    @events = events
    group_events(uniq_dates) 
  end

  private 

  class << self 
    def uniq_dates
      @events.map { |event| event[:date] }.uniq
    end

    def group_events(dates)
      event_array = []
      dates.each do |date|
        grouped_events = @events.select { |event| event[:date] == date }
        event_array << merge_keys(grouped_events, date)
      end
      event_array 
    end 

    def merge_keys(events, date)
      events.inject({date: date}) do |merged_hash, event| 
        event.each do |key, value|
          return if key == date
          merged_hash[key] = value
        end 
        merged_hash
      end 
    end
  end 
end