require 'sqlite3'
require_relative '../../domain/entities/review'

class ReviewRepository::SQLite
  include ReviewRepository

  DB_PATH = File.expand_path('../../../../db/development.sqlite3', __FILE__)

  def initialize
    @db = SQLite3::Database.new(DB_PATH)
    create_table
  end

  def save(review)
    @db.execute(
      "INSERT INTO reviews (id, book_id, user_id, rating, comment) VALUES (?, ?, ?, ?, ?)",
      [review.id, review.book_id, review.user_id, review.rating, review.comment]
    )
  end

  def all_for_book(book_id)
    rows = @db.execute(
      "SELECT id, book_id, user_id, rating, comment FROM reviews WHERE book_id = ?",
      book_id
    )
    rows.map do |row|
      Review.new(
        id: row[0],
        book_id: row[1],
        user_id: row[2],
        rating: row[3],
        comment: row[4]
      )
    end
  end

  private

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS reviews (
        id TEXT PRIMARY KEY,
        book_id TEXT NOT NULL,
        user_id TEXT NOT NULL,
        rating INTEGER NOT NULL,
        comment TEXT
      );
    SQL
  end
end
