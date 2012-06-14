require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'
require 'json'
require 'month_parser'

get '/' do
	page = 0
	processess = []

  @window = 12 # months

  loop {
    data = open("http://timelines-quebec.com/timelines/federal/#{page}/carregar")
    json_data = JSON.parse(data.read)
    
    processess += json_data["processos"]
    
    page += 1
    break unless json_data["processos"].size > 0
  }

  @processess_by_month = parse_by_month(processess, @window)
  processess.to_s
  #erb :index
end


