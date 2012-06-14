require 'sinatra/base'
require 'sinatra/reloader'
require 'open-uri'
require 'json'
require 'month_parser'
require 'cache'

module CanadaChart
  class Application < Sinatra::Base
  
    get '/' do
      @window = 24 # months

      if Cache.get_data
        @processess_by_month = Cache.get_data
      else
        @processess_by_month = parse_by_month(processes, @window)
        Cache.store(@processess_by_month)
      end

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


