require_relative 'app/adapters/repositories/user_repository'
require_relative 'app/adapters/repositories/book_repository'
require_relative 'app/adapters/repositories/review_repository'

require_relative 'app/infrastructure/persistence/sqlite_user_repository'
require_relative 'app/infrastructure/persistence/sqlite_book_repository'
require_relative 'app/infrastructure/persistence/sqlite_review_repository'

module Container
  def self.book_repo
    @book_repo ||= BookRepository::SQLite.new
  end

  def self.user_repo
    @user_repo ||= UserRepository::SQLite.new
  end

  def self.review_repo
    @review_repo ||= ReviewRepository::SQLite.new
  end

  def self.reset!
    @book_repo = @user_repo = @review_repo = nil
  end
end
