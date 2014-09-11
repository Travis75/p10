get '/' do
  erb :index
end

get '/haiku' do
  @parsed = JSON.parse(params[:words])
  words = Haiku.new(@parsed)
  tst = words.create_haiku
  content_type :json
  tst.to_json
end