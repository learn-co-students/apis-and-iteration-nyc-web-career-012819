require 'rest-client'
require 'json'
require 'pry'

def readable(url)
  response_string = RestClient.get(url)
  JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  #make the web request
   response_hash = readable('http://www.swapi.co/api/people/')
  film_info = []
  response_hash["results"].each do |result|
    if result["name"].downcase == character_name.downcase
      films = result["films"]
      films.each do |eachf|
        film_info << readable(eachf)
      end
    end
  end
  film_info
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
  # some iteration magic and puts out the movies in a nice list
  films.each do |info|
    puts info["title"]
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
