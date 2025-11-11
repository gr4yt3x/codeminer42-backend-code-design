require 'securerandom'
require_relative '../entities/review'

class AddReview
  def initialize(review_repo:, book_repo:, user_repo:)
    @review_repo = review_repo
    @book_repo   = book_repo
    @user_repo   = user_repo
  end

  def execute(book_id:, user_id:, rating:, comment: "")
    book = @book_repo.find_by_id(book_id)
    halt 404, { error: "Book not found" }.to_json unless book

    user = @user_repo.find_by_id(user_id)
    halt 404, { error: "User not found" }.to_json unless user

    review = Review.new(
      id: SecureRandom.uuid,
      book_id: book_id,
      user_id: user_id,
      rating: rating,
      comment: comment
    )

    @review_repo.save(review)
    review
  end
end
