class Review
  attr_reader :id, :book_id, :user_id, :rating, :comment

  def initialize(id:, book_id:, user_id:, rating:, comment: "")
    raise ArgumentError, "Rating must be 1-5" unless (1..5).include?(rating)
    @id = id
    @book_id = book_id
    @user_id = user_id
    @rating = rating
    @comment = comment
  end
end
