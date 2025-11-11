require 'sqlite3'
require_relative '../../domain/entities/user'

class UserRepository::SQLite
  include UserRepository

  DB_PATH = File.expand_path('../../../../db/development.sqlite3', __FILE__)

  def initialize
    @db = SQLite3::Database.new(DB_PATH)
    create_table
  end

  def save(user)
    @db.execute("INSERT OR REPLACE INTO users (id, name) VALUES (?, ?)", [user.id, user.name])
  end

  def find_by_id(id)
    row = @db.get_first_row("SELECT id, name FROM users WHERE id = ?", id)
    return nil unless row
    User.new(id: row[0], name: row[1])
  end

  private

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL
      );
    SQL
  end
end
