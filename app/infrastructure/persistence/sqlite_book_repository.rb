require 'sqlite3'
require_relative '../../domain/entities/book'

class BookRepository::SQLite
  include BookRepository

  DB_PATH = File.expand_path('../../../../db/development.sqlite3', __FILE__)

  def initialize
    @db = SQLite3::Database.new(DB_PATH)
    create_table
  end

  def save(book)
    @db.execute(
      "INSERT OR REPLACE INTO books (id, title, author) VALUES (?, ?, ?)",
      [book.id, book.title, book.author]
    )
  end

  def find_by_id(id)
    row = @db.get_first_row("SELECT id, title, author FROM books WHERE id = ?", id)
    return nil unless row
    Book.new(id: row[0], title: row[1], author: row[2])
  end

  def all
    rows = @db.execute("SELECT id, title, author FROM books")
    rows.map do |row|
      Book.new(id: row[0], title: row[1], author: row[2])
    end
  end

  private

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS books (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        author TEXT NOT NULL
      );
    SQL
  end
end
