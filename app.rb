require 'sinatra/base'
require_relative 'container'
require_relative 'routes/books_routes'
require_relative 'routes/reviews_routes'

class BooksApp < Sinatra::Base
  use Routes::Books
  use Routes::Reviews

  run! if app_file == $0
end
