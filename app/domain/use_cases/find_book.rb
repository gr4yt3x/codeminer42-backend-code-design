class FindBook
  def initialize(book_repo)
    @book_repo = book_repo
  end

  def call(id)
    @book_repo.find_by_id(id)
  end
end
