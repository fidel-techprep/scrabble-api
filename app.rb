require "sinatra"
require "sinatra/reloader"


# Load words from the JSON file into an array

json_data = File.read('data.json')
dictionary = JSON.parse(json_data, symbolize_names: true)

def authenticate!
  token = request.env['HTTP_AUTHORIZATION']&.split(' ')&.last
  #halt 401, error_response(401, 'Unauthorized') unless token == API_TOKEN
end

before('/api/*') do
  authenticate!
end

get("/api/random-word") do
  content_type :json
  { word: dictionary.sample }.to_json
end

get("/api/word/:search_word") do
  content_type :json
  search_word = params['search_word'].to_sym
  matching_word = dictionary.fetch(search_word).to_json ||  { error: "Not found" }.to_json
end
