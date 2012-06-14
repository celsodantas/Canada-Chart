require 'active_support/all'

class Cache
  @@cache = {}
  
  def self.get_data
    @@cache[:data] if @@cache[:time].to_i > 1.day.ago.to_i
  end
  
  def self.store(data)
    @@cache[:data] = data
    @@cache[:time] = Time.now
  end
  
end
  
  