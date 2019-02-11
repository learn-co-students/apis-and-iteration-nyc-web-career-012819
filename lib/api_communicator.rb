require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  character = response_hash["results"].find { |person| person["name"].downcase == character_name}

  character["films"].each do |movie|
    a = RestClient.get(movie)
    JSON.parse(a)
  end


  # films_array = []

  # response_hash["results"].each do |person_hash|
  #   if person_hash["name"] == character_name
  #     # puts person_hash["films"]
  #     films_array << person_hash["films"]
  #   end
  #   films_array[0]
  # end

  #
  #
  # films_array[0].each do |film_url|
  #   this_film_api = RestClient.get(film_url)
  #   this_film_api_hash = JSON.parse(this_film_api)
  # end

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # binding.pry
  c = films.map do |movie|
    a = RestClient.get(movie)
    JSON.parse(a)["title"]
  end
  puts "Movies for this character are: #{c.join(", ")}"
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
