require_relative '../app/domain/use_cases/create_book'
require_relative '../app/domain/use_cases/find_book'
require_relative '../container'
require 'json'

module Routes
  class Books < Sinatra::Base

    get '/books' do
      books = Container.book_repo.all 
      json_response(books: books.map(&:to_h))
    end

    post '/books' do
      data = json_params
      title  = data['title']
      author = data['author']

      halt 400, error_json('title and author are required') unless title && author

      use_case = CreateBook.new(Container.book_repo)
      book = use_case.call(title, author)

      status 201
      json_response(book: { id: book.id, title: book.title, author: book.author })
    end

    get '/books/:id' do
      use_case = FindBook.new(Container.book_repo)
      book = use_case.call(params[:id])

      halt 404, error_json('Book not found') unless book

      json_response(book: { id: book.id, title: book.title, author: book.author })
    end

    private

    def json_params
      @json_params ||= JSON.parse(request.body.read)
    rescue
      {}
    end

    def json_response(data)
      content_type :json
      data.to_json
    end

    def error_json(message)
      { error: message }.to_json
    end
  end
end
