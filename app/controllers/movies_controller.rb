class MoviesController < ApplicationController
  # require 'themoviedb-api'
  # Tmdb::Api.key("00ab8363524fc4eb21c71b11eae329c1")
  # Tmdb::Api.language("ja") # こちらで映画情報の表示の際の言語設定を日本語にできます

  def index
      if params[:looking_for]
        movie_title = params[:looking_for]
        movies = []
        (1..5).each do |page|
          url = "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['TMDB_API']}&language=ja&query=" + URI.encode_www_form_component(movie_title) + "&page=#{page}"
          response = Net::HTTP.get_response(URI.parse(url))
          if response.code == "200"
            result = JSON.parse(response.body)
            movies.concat(result["results"])
          end
        end
      else
        movies = []
        (1..5).each do |page|
          url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API']}&language=ja&page=#{page}"
          response = Net::HTTP.get_response(URI.parse(url))
          if response.code == "200"
            result = JSON.parse(response.body)
            movies.concat(result["results"])
          end
        end
      end
      @movies = Kaminari.paginate_array(movies).page(params[:page]).per(20)
  end
end