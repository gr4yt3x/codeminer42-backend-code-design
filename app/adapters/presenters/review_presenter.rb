class ReviewPresenter
  def initialize(review, user_repo)
    @review = review
    @user_repo = user_repo
  end

  def to_h
    user = @user_repo.find_by_id(@review.user_id)
    {
      id: @review.id,
      book_id: @review.book_id,
      rating: @review.rating,
      comment: @review.comment,
      user: user&.name || "Unknown"
    }
  end
end
