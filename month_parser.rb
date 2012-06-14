require 'active_support/all'

def parse_by_month(processess, window) 
  one_day = (60 * 60 * 24)
  
  by_month = []
  index    = 0
  
  window.times do |i|
    first_day = i.month.ago.at_beginning_of_month
    last_day  = i.month.ago.at_end_of_month
    
    by_month[index] = 0
    
    processess.each do |process|
      time = process["processoTempoFederal"].to_i
      
      if time.days.ago > first_day && time.days.ago < last_day
        by_month[index] += 1
      end
    end
    
    index += 1
  end
  by_month.reverse
end