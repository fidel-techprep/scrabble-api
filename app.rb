require "sinatra"
require "sinatra/reloader"

API_KEY = ENV.fetch("API_KEY")
PERSONAL_API_KEY = ENV.fetch("PERSONAL_API_KEY")

# Helper method to return JSON error responses
def error_response(status, message)
  content_type :json
  status status
  { error: message }.to_json
end

# Load words from the JSON file into an array
json_data = File.read('data.json')
dictionary = JSON.parse(json_data, symbolize_names: true)

# Authentication method
def authenticate
  # Extract token from header
  token = request.env['HTTP_AUTHORIZATION']&.split(' ')&.last

  # Halt response and resturn error if token is invalid
  halt 401, error_response(401, 'Unauthorized') unless token == API_KEY || token == PERSONAL_API_KEY 
end

# Authentication for API routes
before('/api/*') do
  authenticate
end

# Return a random word
get("/api/random-word") do
  content_type :json
  { word: dictionary.sample }.to_json
end

# Return the score for a requested word
get("/api/word/:search_word") do
  content_type :json
  search_word = params['search_word'].to_sym
  matching_word = dictionary.fetch(search_word, { error: "Not found" }).to_json
end

# Error handling for invalid endpoints
not_found do
  error_response 404, 'Endpoint not found'
end

# Error handling for other server errors
error do
  error_response 500, 'Internal server error'
end
