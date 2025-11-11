require 'securerandom'
require_relative '../entities/book'

class CreateBook
  def initialize(book_repo)
    @book_repo = book_repo
  end

  def call(title, author)
    book = Book.new(
      id: SecureRandom.uuid,
      title: title,
      author: author
    )
    @book_repo.save(book)
    book
  end
end
