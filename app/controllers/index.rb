require 'httparty'

get '/' do
  erb :index
end

get '/image_tag' do
  p params[:image_url]
  response = HTTParty.get('http://access.alchemyapi.com/calls/url/URLGetRankedImageKeywords', query: {url: "#{params[:image_url]}", apikey: '0b3dfa53d1a302f01510dca6b16cd115c395418b', outputMode: 'json'})
  p response
  stripped = Synonym.break_results(response.parsed_response)
  ary = [stripped]
  Synonym.get_syn(stripped) {|word|
    res = HTTParty.get("http://words.bighugelabs.com/api/2/ee73e74d6bf5f586aedf3acdc90db12a/#{word}/json")
    res = JSON.parse(res)
    ary << res["noun"]["syn"]
  }
  p ary
  finished_haiku = Haiku.new(ary.flatten)
  finished_haiku.create_haiku
  content_type :json
    finished_haiku.haiku.to_json
end