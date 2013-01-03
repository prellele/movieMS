require 'net/http'

# Hack out caching
class ImdbParty::Imdb
  cache store: :memory
  def self.get(path, options={})
    self.get_without_caching(path, options)
  end
end


require 'ruby-tmdb3'

Tmdb.api_key = "464f9136f4a2b5db6071299ddb1c9c59"
Tmdb.default_language = "de"
