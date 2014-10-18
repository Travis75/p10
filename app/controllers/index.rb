require 'httparty'

get '/' do
  erb :index
end

#This is Clarifai solution. Use if there are no bugs with Clarifai.
get '/image_tag' do
  #stub_data = ["pavement", "nobody", "empty", "line", "stairs", "stride", "road", "house", "industry", "street", "shadow", "energy", "sidewalk", "perspective", "picker", "building", "row", "daytime", "urban", "roof"]

  response = HTTParty.post('https://api.clarifai.com/v1/token/', query: {grant_type: "client_credentials", client_id: "fNrszjnk-grLt_v9v0bw3NPst6DcI43ZgGyn7TFE", client_secret: "Hq0XfUAXbKgUEtLS3p4tPU9ZKvsxAFRkDvwU2DD2"})
  # response = HTTParty.post('https://api.clarifai.com/v1/token/', query: {grant_type: "client_credentials", client_id: ENV["CLIENT_ID"], client_secret: ENV["CLIENT_SECRET"]})
  token = response["access_token"]
  words = HTTParty.get("https://api.clarifai.com/v1/tag/?url=#{params[:image_url]}", headers: {"Authorization" => "Bearer #{token}"})
  finished_haiku = Haiku.new(words["results"][0]["result"]["tag"]["classes"])
  finished_haiku.create_haiku
  content_type :json
    finished_haiku.haiku.to_json
end

# While Clarifai is in beta/if there is a problem with beta or rate limiting occurs this is the workaround solution to continue to grab enough words for a haiku using another API (Alchemy API).

# get '/image_tag' do
#   p params[:image_url]
#   response = HTTParty.get('http://access.alchemyapi.com/calls/url/URLGetRankedImageKeywords', query: {url: "#{params[:image_url]}", apikey: ENV["API_KEY"], outputMode: 'json'})
#   stripped = Synonym.break_results(response.parsed_response)
#   ary = [stripped]
#   Synonym.get_syn(stripped) {|word|
#     res = HTTParty.get("http://words.bighugelabs.com/api/2/ee73e74d6bf5f586aedf3acdc90db12a/#{word}/json")
#     res = JSON.parse(res)
#     ary << res["noun"]["syn"]
#   }
#   finished_haiku = Haiku.new(ary.flatten)
#   finished_haiku.create_haiku
#   content_type :json
#     finished_haiku.haiku.to_json
# end
