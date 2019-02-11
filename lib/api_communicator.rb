require 'rest-client'
require 'json'
require 'pry'


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each { |film| puts film["title"] }
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

def get_character_movies_from_api(character_name)
  # The web addresses for all of the character's films

  film_urls = get_movies_from_character(get_character_from_api(character_name))
  # Iterate over and get all the hashes and compile them into an array
  movies_array = []
  film_urls.each do |url|
    response_string = RestClient.get(url)
    response_hash = JSON.parse(response_string)
    movies_array << response_hash
  end
  # Return movies array
  movies_array
end

def get_character_from_api(character_name)
  # Get json for all characters
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  characters = response_hash["results"]
  # The found character
  result = characters.find { |element| element["name"] == character_name }
end

def get_movies_from_character(character_hash)
  character_hash["films"]
end

