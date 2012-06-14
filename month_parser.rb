require 'active_support/all'

def parse_by_month(processess, window) 
  one_day = (60 * 60 * 24)
  
  by_month = []
  index    = 0
  
  window.times do |i|
    by_month[index] = 0
    
    year  = i.months.ago.year
    month = i.months.ago.month
    
    first_day = (Time.now - i.months.ago.at_beginning_of_month) / 1.day
    last_day  = (Time.now - i.months.ago.at_end_of_month) / 1.day
  
    processess.each do |process|
      days_ago = process["processoTempoFederal"].to_i
      p days_ago
      p first_day
      p last_day
      by_month[index] += 1 if days_ago > first_day && days_ago < last_day
    end
    
    index += 1
  end
  by_month.reverse
end