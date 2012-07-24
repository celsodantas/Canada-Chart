require 'sinatra/base'
require 'sinatra/reloader'
require 'open-uri'
require 'json'
require './month_parser'
require './cache'

module CanadaChart
  class Application < Sinatra::Base
  
    get '/' do
      @window = 24 # months

      if Cache.get_data
        @datas = Cache.get_data
      else
        @datas = Hash.new
        @datas[:process] = parse_by_month(processes, @window)
        @datas[:exams]   = parse_medical_exam_received_by_month(processes, @window)
        
        Cache.store(@datas)
      end
      
       @processess_by_month = @datas[:process]
       @exams_by_month      = @datas[:exams]

      erb :index
    end
    
    def processes
      processes = []

      page = 0
      loop {
        data = open("http://timelines-quebec.com/timelines/federal/#{page}/carregar")
        json_data = JSON.parse(data.read)
    
        processes += json_data["processos"]
    
        page += 1
        break unless json_data["processos"].size > 0
      }
      
      processes
    end
  end
end


