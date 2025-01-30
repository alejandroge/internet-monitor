# frozen_string_literal: true

require 'sqlite3'

# Class to set up the database for the project
class DbConnection
  DB_NAME = '/db-data/disconnections.sqlite3'

  INIT_SQL = <<-SQL
    CREATE TABLE IF NOT EXISTS network_disconnections (
      id INTEGER PRIMARY KEY,
      created_at INTEGER NOT NULL,
      disconnected_at INTEGER NOT NULL,
      reconnected_at INTEGER NOT NULL,
      duration INTEGER
    );
    CREATE INDEX IF NOT EXISTS created_at_index ON network_disconnections(created_at);
  SQL

  # @return [SQLite3::Database]
  def self.create_new_connection!
    conn = SQLite3::Database.new(DB_NAME)

    conn.execute(INIT_SQL)

    conn
  end
end
