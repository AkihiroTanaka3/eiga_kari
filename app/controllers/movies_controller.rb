class MoviesController < ApplicationController
  require 'themoviedb-api'
  Tmdb::Api.key("00ab8363524fc4eb21c71b11eae329c1")
  Tmdb::Api.language("ja") # こちらで映画情報の表示の際の言語設定を日本語にできます

  def search
  end
  
  def show
  end
end